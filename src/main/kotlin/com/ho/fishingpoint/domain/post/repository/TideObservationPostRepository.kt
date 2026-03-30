package com.ho.fishingpoint.domain.post.repository

import com.ho.fishingpoint.domain.post.entity.TideObservationPost
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface TideObservationPostRepository: JpaRepository<TideObservationPost, String> {
}