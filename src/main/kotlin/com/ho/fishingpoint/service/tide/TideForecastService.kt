package com.ho.fishingpoint.service.tide

import com.ho.fishingpoint.domain.tide.repository.TideForecastQueryRepository
import com.ho.fishingpoint.domain.tide.repository.TideForecastRepository
import com.ho.fishingpoint.model.tide.TideForecastDto
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.LocalDate
import org.springframework.data.domain.Page
import org.springframework.data.domain.PageRequest

@Service
@Transactional(readOnly = true)
class TideForecastService(
    private val tideForecastRepository: TideForecastRepository,
    private val tideForecastQueryRepository: TideForecastQueryRepository
) {
    fun findByPostIdAndDate(obsPostId: String, date: LocalDate): List<TideForecastDto> {
        return tideForecastQueryRepository
            .findByPostIdAndDate(obsPostId, date)
            .map { TideForecastDto.from(it) }
    }

    fun findByPostId(obsPostId: String, page: Int, size: Int): Page<TideForecastDto> {
        return tideForecastQueryRepository
            .findByPostId(obsPostId, PageRequest.of(page, size))
            .map { TideForecastDto.from(it) }
    }
}