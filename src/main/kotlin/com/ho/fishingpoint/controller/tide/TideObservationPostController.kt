package com.ho.fishingpoint.controller.tide

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/v1/tide-observation-posts")
class TideObservationPostController(
) {
    @GetMapping
    fun list() {

    }

    @GetMapping("/{id}")
    fun findById(@PathVariable id: Long) {

    }
}