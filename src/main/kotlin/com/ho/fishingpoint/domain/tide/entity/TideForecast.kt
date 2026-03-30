package com.ho.fishingpoint.domain.tide.entity

import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
@Table(
    name = "tb_tide_forecast",
    uniqueConstraints = [
        UniqueConstraint(
            name = "uq_tide_forecast_post_dt",
            columnNames = ["obs_post_id", "forecast_dt"]  // ON CONFLICT 기준
        )
    ]
)
class TideForecast(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Column(name = "obs_post_id", nullable = false, length = 20)
    val obsPostId: String,

    @Column(name = "obs_post_name", nullable = false)
    val obsPostName: String,

    // predcDt 그대로 합쳐서 저장 (날짜+시각)
    @Column(name = "forecast_dt", nullable = false)
    val forecastDt: LocalDateTime,

    // 예측 조위값 (cm)
    @Column(name = "tide_level", nullable = false)
    val tideLevel: Int,

    // 극치구분 코드 (1~4)
    @Column(name = "extr_se", nullable = false)
    val extrSe: Int,

    // 극치구분 설명 (오전 고조 / 오전 저조 / 오후 고조 / 오후 저조)
    @Column(name = "tide_type", nullable = false)
    val tideType: String,

    // 만조 여부
    @Column(name = "is_high_tide", nullable = false)
    val isHighTide: Boolean,
) {
    @Column(name = "created_at", updatable = false)
    val createdAt: LocalDateTime = LocalDateTime.now()
}