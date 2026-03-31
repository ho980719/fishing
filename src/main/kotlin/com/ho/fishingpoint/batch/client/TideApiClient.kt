package com.ho.fishingpoint.batch.client

import com.ho.fishingpoint.batch.client.dto.TideApiResponse
import com.ho.fishingpoint.global.config.client.DataPortalProperties
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Component
import org.springframework.web.reactive.function.client.WebClient
import reactor.core.publisher.Mono
import java.time.LocalDate

@Component
class TideApiClient(
    private val dataPortalWebClient: WebClient,
    private val properties: DataPortalProperties
) {
    private val log = LoggerFactory.getLogger(javaClass)

    fun fetchTide(obsCode: String): Mono<TideApiResponse> {
        return dataPortalWebClient.get()
            .uri { builder ->
                builder
                    .path(properties.tidePath)
                    .queryParam("serviceKey", properties.serviceKey)
                    .queryParam("pageNo", 1)
                    .queryParam("numOfRows", 100)
                    .queryParam("type", "JSON")
                    .queryParam("obsCode", obsCode)
                    .build()
            }
            .retrieve()
            .onStatus({ it.isError }) { response ->
                response.bodyToMono(String::class.java).flatMap { body ->
                    log.error("[TideApiClient] HTTP 에러 - status: {}, body: {}", response.statusCode(), body)
                    Mono.error(RuntimeException("API HTTP 에러: ${response.statusCode()}"))
                }
            }
            .bodyToMono(TideApiResponse::class.java)
            .doOnSuccess { res ->
                res ?: return@doOnSuccess  // null guard
                if (res.header.resultCode != "00") {
                    log.warn("[TideApiClient] API 에러 응답 - code: {}, msg: {}",
                        res.header.resultCode,
                        res.header.resultMsg
                    )
                }
            }
            .doOnError { e ->
                log.error("[TideApiClient] 요청 실패 - obsPostId: {}, today: {}, 원인: {}",
                    obsCode, LocalDate.now(), e.message
                )
            }
    }
}