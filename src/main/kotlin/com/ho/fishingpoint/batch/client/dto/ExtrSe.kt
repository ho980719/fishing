package com.ho.fishingpoint.batch.client.dto

enum class ExtrSe(val code: Int, val description: String) {
    AM_HIGH(1, "오전 고조"),
    AM_LOW(2, "오전 저조"),
    PM_HIGH(3, "오후 고조"),
    PM_LOW(4, "오후 저조");

    val isHighTide: Boolean get() = this == AM_HIGH || this == PM_HIGH

    companion object {
        fun from(code: Int): ExtrSe =
            entries.find { it.code == code }
                ?: throw IllegalArgumentException("알 수 없는 극치구분 코드: $code")
    }
}