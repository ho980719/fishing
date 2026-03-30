// batch/scheduler/TideScheduler.kt
package com.ho.fishingpoint.batch.scheduler

import net.javacrumbs.shedlock.spring.annotation.SchedulerLock
import org.slf4j.LoggerFactory
import org.springframework.batch.core.job.Job
import org.springframework.batch.core.job.parameters.JobParameters
import org.springframework.batch.core.job.parameters.JobParametersBuilder
import org.springframework.batch.core.launch.JobOperator
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import java.time.LocalDateTime

@Component
class TideScheduler(
    private val jobOperator: JobOperator,
    private val tideJob: Job
) {
    private val log = LoggerFactory.getLogger(javaClass)

    @Scheduled(cron = "0 0 1 * * *", zone = "Asia/Seoul")
    @SchedulerLock(
        name = "tideJob",
        lockAtLeastFor = "PT30M",
        lockAtMostFor = "PT1H"
    )
    fun runTideJob() {
        launch()
    }

    fun runManually() {
        log.info("[TideScheduler] 수동 실행 트리거")
        launch()
    }

    private fun launch() {
        val params: JobParameters = JobParametersBuilder()
            .addString("executedAt", LocalDateTime.now().toString())
            .toJobParameters()

        runCatching {
            val execution = jobOperator.start(tideJob, params)
            log.info("[TideScheduler] 완료 - status: {}, jobId: {}",
                execution.status,
                execution.jobInstanceId
            )
        }.onFailure { e ->
            log.error("[TideScheduler] 실패", e)
        }
    }
}