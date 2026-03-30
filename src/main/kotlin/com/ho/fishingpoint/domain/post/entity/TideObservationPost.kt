package com.ho.fishingpoint.domain.post.entity

import jakarta.persistence.*
import org.locationtech.jts.geom.Point
import java.time.LocalDateTime

@Entity
@Table(name = "tb_tide_observation_post")
class TideObservationPost(
    @Id
    @Column(name = "post_id")
    val postId: String,

    @Column(name = "post_name", nullable = false)
    var postName: String,

    @Column(name = "category")
    var category: String?,

    @Enumerated(EnumType.STRING)
    @Column(name = "sea_zone")
    var seaZone: SeaZone?,

    @Column(name = "location", columnDefinition = "geography(Point, 4326)")
    var location: Point? = null
) {
    @Column(name = "created_at", updatable = false)
    val createdAt: LocalDateTime = LocalDateTime.now()
}