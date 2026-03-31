package com.ho.fishingpoint.domain.tide.repository

import com.ho.fishingpoint.domain.tide.entity.QTideForecast
import com.ho.fishingpoint.domain.tide.entity.TideForecast
import com.querydsl.jpa.impl.JPAQueryFactory
import org.springframework.data.domain.Page
import org.springframework.data.domain.PageImpl
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Repository
import java.time.LocalDate

@Repository
class TideForecastQueryRepository(
    private val queryFactory: JPAQueryFactory
) {
    private val tideForecast = QTideForecast.tideForecast

    fun findByPostIdAndDate(obsPostId: String, date: LocalDate): List<TideForecast> {
        return queryFactory
            .selectFrom(tideForecast)
            .where(
                tideForecast.obsPostId.eq(obsPostId),
                tideForecast.forecastDt.goe(date.atStartOfDay()),
                tideForecast.forecastDt.lt(date.plusDays(1).atStartOfDay())
            )
            .orderBy(tideForecast.forecastDt.asc())
            .fetch()
    }

    fun findByPostId(obsPostId: String, pageable: Pageable): Page<TideForecast> {
        val content = queryFactory
            .selectFrom(tideForecast)
            .where(tideForecast.obsPostId.eq(obsPostId))
            .orderBy(tideForecast.forecastDt.asc())
            .offset(pageable.offset)
            .limit(pageable.pageSize.toLong())
            .fetch()

        val total = queryFactory
            .select(tideForecast.count())
            .from(tideForecast)
            .where(tideForecast.obsPostId.eq(obsPostId))
            .fetchOne() ?: 0L

        return PageImpl(content, pageable, total)
    }
}