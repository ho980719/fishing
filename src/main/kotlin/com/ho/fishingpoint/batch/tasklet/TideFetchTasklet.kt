package com.ho.fishingpoint.batch.tasklet

import com.ho.fishingpoint.batch.client.TideApiClient
import com.ho.fishingpoint.batch.client.dto.ExtrSe
import com.ho.fishingpoint.domain.post.entity.TideObservationPost
import com.ho.fishingpoint.domain.post.repository.TideObservationPostRepository
import com.ho.fishingpoint.domain.tide.entity.TideForecast
import com.ho.fishingpoint.domain.tide.repository.TideForecastRepository
import org.slf4j.LoggerFactory
import org.springframework.batch.core.scope.context.ChunkContext
import org.springframework.batch.core.step.StepContribution
import org.springframework.batch.core.step.tasklet.Tasklet
import org.springframework.batch.infrastructure.repeat.RepeatStatus
import org.springframework.stereotype.Component
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

@Component
class TideFetchTasklet(
    private val tideApiClient: TideApiClient,
    private val tideObservationPostRepository: TideObservationPostRepository,
    private val tideForecastRepository: TideForecastRepository
) : Tasklet {

    private val log = LoggerFactory.getLogger(javaClass)
    private val dateFmt = DateTimeFormatter.ofPattern("yyyyMMdd")
    private val predcDtFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")

    override fun execute(contribution: StepContribution, chunkContext: ChunkContext): RepeatStatus {
        val stations = tideObservationPostRepository.findAll()
        if (stations.isEmpty()) {
            log.warn("[TideFetchTasklet] 등록된 관측소가 없습니다. 배치를 종료합니다.")
            return RepeatStatus.FINISHED
        }

        val today = LocalDate.now()
        val dates = (0 until 7).map { today.plusDays(it.toLong()) }

        log.info(
            "[TideFetchTasklet] 시작 - 관측소: {}개, 기간: {} ~ {}",
            stations.size, dates.first(), dates.last()
        )

        var totalSaved = 0
        var totalSkipped = 0

        stations.forEach { station ->
            dates.forEach { date ->
                runCatching {
                    fetchAndSave(station, date).also { totalSaved += it }
                }.onFailure { e ->
                    log.error(
                        "[TideFetchTasklet] 수집 실패 - 관측소: {}({}), 날짜: {}, 원인: {}",
                        station.postName, station.postId, date, e.message
                    )
                    contribution.incrementProcessSkipCount()
                    totalSkipped++
                }
            }
        }

        log.info("[TideFetchTasklet] 완료 - 저장: {}건, 실패: {}건", totalSaved, totalSkipped)
        return RepeatStatus.FINISHED
    }

    private fun fetchAndSave(station: TideObservationPost, date: LocalDate): Int {
        val items = tideApiClient
            .fetchTide(station.postId, date.format(dateFmt))
            .block()
            ?.body?.items?.item
            .orEmpty()

        if (items.isEmpty()) {
            log.debug("[TideFetchTasklet] 데이터 없음 - 관측소: {}({}), 날짜: {}",
                station.postName, station.postId, date
            )
            return 0
        }

        var savedCount = 0
        items.forEach { item ->
            runCatching {
                val extrSe = ExtrSe.from(item.extrSe)
                val forecastDt = LocalDateTime.parse(item.predcDt, predcDtFmt)

                tideForecastRepository.upsert(
                    obsPostId   = station.postId,
                    obsPostName = item.obsvtrNm,
                    forecastDt  = forecastDt,
                    tideLevel   = item.predcTdlvVl.toInt(),
                    extrSe      = item.extrSe,
                    tideType    = extrSe.description,
                    isHighTide  = extrSe.isHighTide
                )
                savedCount++
            }.onFailure { e ->
                log.warn("[TideFetchTasklet] 아이템 upsert 실패 - predcDt: {}, 원인: {}",
                    item.predcDt, e.message
                )
            }
        }

        log.debug("[TideFetchTasklet] upsert 완료 - 관측소: {}({}), 날짜: {}, {}건",
            station.postName, station.postId, date, savedCount
        )
        return savedCount
    }

}