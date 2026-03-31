package com.ho.fishingpoint.controller

import com.ho.fishingpoint.batch.scheduler.TideScheduler
import com.ho.fishingpoint.domain.post.entity.TideObservationPost
import com.ho.fishingpoint.domain.post.repository.TideObservationPostRepository
import com.ho.fishingpoint.domain.tide.entity.TideForecast
import com.ho.fishingpoint.domain.tide.repository.TideForecastRepository
import org.springframework.format.annotation.DateTimeFormat
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.time.LocalDate

@RestController
@RequestMapping("/api/v1/test")
class TestController(
    private val postRepository: TideObservationPostRepository,
    private val tideForecastRepository: TideForecastRepository,
    private val tideScheduler: TideScheduler
) {

    // ── 관측소 ──────────────────────────────────────────────

    @GetMapping("/posts")
    fun getAllPosts(): List<TideObservationPost> {
        return postRepository.findAll()
    }

    @GetMapping("/posts/{id}")
    fun getPostById(@PathVariable id: String): TideObservationPost? {
        return postRepository.findById(id).orElse(null)
    }

    // ── 조석 예보 ────────────────────────────────────────────

    /** 전체 조회 */
    @GetMapping("/tides")
    fun getAllTides(): List<TideForecast> {
        return tideForecastRepository.findAll()
    }

    /** 관측소별 조회 */
    @GetMapping("/tides/{obsPostId}")
    fun getTidesByPost(@PathVariable obsPostId: String): List<TideForecast> {
        return tideForecastRepository.findByObsPostId(obsPostId)
    }

    /** 날짜 범위 조회 */
    @GetMapping("/tides/range")
    fun getTidesByRange(
        @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") from: LocalDate,
        @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") to: LocalDate
    ): List<TideForecast> {
        return tideForecastRepository.findByForecastDtBetween(
            from.atStartOfDay(),
            to.atTime(23, 59, 59)
        )
    }

    // ── 배치 수동 실행 ────────────────────────────────────────

    @PostMapping("/batch/tide/run")
    fun runTideBatch(): ResponseEntity<String> {
        tideScheduler.runManually()
        return ResponseEntity.ok("조석 배치 수동 실행 완료")
    }
}