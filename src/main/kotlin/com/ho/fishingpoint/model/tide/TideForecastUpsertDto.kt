package com.ho.fishingpoint.model.tide

import java.time.LocalDateTime

data class TideForecastUpsertDto(
    val obsPostId: String,
    val obsPostName: String,
    val forecastDt: LocalDateTime,
    val tideLevel: Int,
    val extrSe: Int,
    val tideType: String,
    val isHighTide: Boolean,
)