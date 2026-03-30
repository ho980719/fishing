package com.ho.fishingpoint.global.config.client

import org.springframework.boot.context.properties.ConfigurationProperties


@ConfigurationProperties(prefix = "external-api.data-portal")
data class DataPortalProperties(
    val baseHost: String,
    val serviceKey: String
)
