package com.ho.fishingpoint.service.tide

import com.ho.fishingpoint.domain.post.entity.TideObservationPost
import com.ho.fishingpoint.domain.post.repository.TideObservationPostRepository
import org.locationtech.jts.geom.Coordinate
import org.locationtech.jts.geom.GeometryFactory
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class TideObservationPostService(
    private val tideObservationPostRepository: TideObservationPostRepository
) {
    @Transactional
    fun updateLocationIfAbsent(station: TideObservationPost, lot: Double, lat: Double) {
        if (station.location != null) return

        val point = GeometryFactory().createPoint(Coordinate(lot, lat)).also {
            it.srid = 4326
        }
        station.location = point
    }
}