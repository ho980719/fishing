package com.ho.fishingpoint.batch.job

import com.ho.fishingpoint.batch.tasklet.TideFetchTasklet
import org.springframework.batch.core.job.Job
import org.springframework.batch.core.job.builder.JobBuilder
import org.springframework.batch.core.repository.JobRepository
import org.springframework.batch.core.step.Step
import org.springframework.batch.core.step.builder.StepBuilder
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.transaction.PlatformTransactionManager

@Configuration
class TideJobConfig(
    private val jobRepository: JobRepository,
    private val transactionManager: PlatformTransactionManager,
    private val tideFetchTasklet: TideFetchTasklet
) {
    @Bean
    fun tideJob(): Job = JobBuilder("tideJob", jobRepository)
        .start(tideFetchStep())
        .build()

    @Bean
    fun tideFetchStep(): Step = StepBuilder("tideFetchStep", jobRepository)
        .tasklet(tideFetchTasklet, transactionManager)
        .build()
}