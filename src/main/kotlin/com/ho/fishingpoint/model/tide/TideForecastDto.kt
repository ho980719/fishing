package com.ho.fishingpoint.model.tide

import com.fasterxml.jackson.annotation.JsonFormat
import com.ho.fishingpoint.domain.tide.entity.TideForecast
import java.time.LocalDateTime

data class TideForecastDto(
    val id: Long,
    val obsPostId: String,
    val obsPostName: String,
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    val forecastDt: LocalDateTime,
    val tideLevel: Int,
    val extrSe: Int,
    val tideType: String,
    val isHighTide: Boolean,
) {
    companion object {
        fun from(entity: TideForecast) = TideForecastDto(
            id          = entity.id,
            obsPostId   = entity.obsPostId,
            obsPostName = entity.obsPostName,
            forecastDt  = entity.forecastDt,
            tideLevel   = entity.tideLevel,
            extrSe      = entity.extrSe,
            tideType    = entity.tideType,
            isHighTide  = entity.isHighTide,
        )
    }
}