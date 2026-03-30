package com.ho.fishingpoint.global.util

import org.locationtech.jts.geom.Coordinate
import org.locationtech.jts.geom.GeometryFactory
import org.locationtech.jts.geom.Point
import org.locationtech.jts.geom.PrecisionModel
import org.springframework.stereotype.Component

@Component
class GeometryUtil {
    // SRID 4326: 위경도 좌표계(WGS84) 표준
    private val geometryFactory = GeometryFactory(PrecisionModel(), 4326)

    fun createPoint(longitude: Double, latitude: Double): Point {
        // JTS는 (X, Y) 순서 (경도, 위도)
        return geometryFactory.createPoint(Coordinate(longitude, latitude))
    }
}