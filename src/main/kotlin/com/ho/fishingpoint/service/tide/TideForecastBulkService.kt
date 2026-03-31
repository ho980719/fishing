package com.ho.fishingpoint.service.tide

import com.ho.fishingpoint.model.tide.TideForecastUpsertDto
import jakarta.transaction.Transactional
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.stereotype.Service

@Service
class TideForecastBulkService(
    private val jdbcTemplate: JdbcTemplate
) {
    @Transactional
    fun bulkUpsert(rows: List<TideForecastUpsertDto>) {
        val sql = """
            INSERT INTO tb_tide_forecast 
                (obs_post_id, obs_post_name, forecast_dt, tide_level, extr_se, tide_type, is_high_tide, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, NOW())
            ON CONFLICT (obs_post_id, forecast_dt)
            DO UPDATE SET
                tide_level   = EXCLUDED.tide_level,
                extr_se      = EXCLUDED.extr_se,
                tide_type    = EXCLUDED.tide_type,
                is_high_tide = EXCLUDED.is_high_tide
        """.trimIndent()

        rows.chunked(500).forEach { chunk ->  // 500건씩 청킹
            jdbcTemplate.batchUpdate(sql, chunk.map { row ->
                arrayOf(
                    row.obsPostId,
                    row.obsPostName,
                    row.forecastDt,
                    row.tideLevel,
                    row.extrSe,
                    row.tideType,
                    row.isHighTide
                )
            })
        }
    }
}