package com.ho.fishingpoint.domain.tide.repository

import com.ho.fishingpoint.domain.tide.entity.TideForecast
import jakarta.transaction.Transactional
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import java.time.LocalDateTime

interface TideForecastRepository : JpaRepository<TideForecast, Long> {

    fun findByObsPostId(obsPostId: String): List<TideForecast>

    fun findByForecastDtBetween(from: LocalDateTime, to: LocalDateTime): List<TideForecast>

    @Transactional
    @Modifying(clearAutomatically = true)
    @Query(
        value = """
            INSERT INTO tb_tide_forecast 
                (obs_post_id, obs_post_name, forecast_dt, tide_level, extr_se, tide_type, is_high_tide, created_at)
            VALUES 
                (:obsPostId, :obsPostName, :forecastDt, :tideLevel, :extrSe, :tideType, :isHighTide, NOW())
            ON CONFLICT (obs_post_id, forecast_dt)
            DO UPDATE SET
                tide_level   = EXCLUDED.tide_level,
                extr_se      = EXCLUDED.extr_se,
                tide_type    = EXCLUDED.tide_type,
                is_high_tide = EXCLUDED.is_high_tide
        """,
        nativeQuery = true
    )
    fun upsert(
        @Param("obsPostId") obsPostId: String,
        @Param("obsPostName") obsPostName: String,
        @Param("forecastDt") forecastDt: LocalDateTime,
        @Param("tideLevel") tideLevel: Int,
        @Param("extrSe") extrSe: Int,
        @Param("tideType") tideType: String,
        @Param("isHighTide") isHighTide: Boolean,
    ): Int
}