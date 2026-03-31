package com.ho.fishingpoint.controller.tide

import com.ho.fishingpoint.model.tide.TideForecastDto
import com.ho.fishingpoint.service.tide.TideForecastService
import org.springframework.data.domain.Page
import org.springframework.format.annotation.DateTimeFormat
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import java.time.LocalDate

@RestController
@RequestMapping("/api/v1/tide-forecasts")
class TideForecastController(
    private val tideForecastService: TideForecastService,
) {

    // 관측소 + 날짜 조회
    @GetMapping("/{obsPostId}/{date}")
    fun getByPostIdAndDate(
        @PathVariable obsPostId: String,
        @PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) date: LocalDate,
    ): ResponseEntity<List<TideForecastDto>> {
        return ResponseEntity.ok(tideForecastService.findByPostIdAndDate(obsPostId, date))
    }

    // 관측소 전체 조회
    @GetMapping("/{obsPostId}")
    fun getByPostId(
        @PathVariable obsPostId: String,
        @RequestParam(defaultValue = "0") page: Int,
        @RequestParam(defaultValue = "20") size: Int,
    ): ResponseEntity<Page<TideForecastDto>> {
        return ResponseEntity.ok(tideForecastService.findByPostId(obsPostId, page, size))
    }
}