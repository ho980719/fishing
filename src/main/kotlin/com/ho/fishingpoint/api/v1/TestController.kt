package com.ho.fishingpoint.api.v1

import com.ho.fishingpoint.domain.post.entity.TideObservationPost
import com.ho.fishingpoint.domain.post.repository.TideObservationPostRepository
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/v1/test")
class TestController(
    private val postRepository: TideObservationPostRepository
) {

    @GetMapping("/posts")
    fun getAllPosts(): List<TideObservationPost> {
        return postRepository.findAll()
    }

    @GetMapping("/posts/{id}")
    fun getPostById(@PathVariable id: String): TideObservationPost? {
        return postRepository.findById(id).orElse(null)
    }
}