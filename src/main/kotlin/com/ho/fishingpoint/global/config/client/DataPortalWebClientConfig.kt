package com.ho.fishingpoint.global.config.client

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.reactive.function.client.WebClient
import org.springframework.web.util.DefaultUriBuilderFactory

@Configuration
class DataPortalWebClientConfig(
    private val properties: DataPortalProperties
) {
    @Bean
    fun dataPortalWebClient(DataPortalProperties: DataPortalProperties): WebClient {
        val factory = DefaultUriBuilderFactory(properties.baseHost)
        factory.encodingMode = DefaultUriBuilderFactory.EncodingMode.VALUES_ONLY

        return WebClient.builder()
            .uriBuilderFactory(factory)
            .baseUrl(properties.baseHost)
            .build()
    }
}