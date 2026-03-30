package com.ho.fishingpoint.batch.client.dto

import com.fasterxml.jackson.annotation.JsonProperty

data class TideApiResponse(
    @JsonProperty("header")
    val header: TideHeader,
    @JsonProperty("body")
    val body: TideBody?
)

data class TideHeader(
    @JsonProperty("resultCode")
    val resultCode: String,
    @JsonProperty("resultMsg")
    val resultMsg: String
)

data class TideBody(
    @JsonProperty("items")
    val items: TideItems?,
    @JsonProperty("pageNo")
    val pageNo: Int,
    @JsonProperty("numOfRows")
    val numOfRows: Int,
    @JsonProperty("totalCount")
    val totalCount: Int,
    @JsonProperty("type")
    val type: String?
)

data class TideItems(
    @JsonProperty("item")
    val item: List<TideItem> = emptyList()
)

data class TideItem(
    @JsonProperty("obsvtrNm")
    val obsvtrNm: String,           // 예보지점명
    @JsonProperty("lot")
    val lot: Double,                // 경도
    @JsonProperty("lat")
    val lat: Double,                // 위도
    @JsonProperty("predcDt")
    val predcDt: String,            // 예측일시
    @JsonProperty("predcTdlvVl")
    val predcTdlvVl: Double,        // 예측조위값 (cm)
    @JsonProperty("extrSe")
    val extrSe: Int                 // 극치구분 (1~4)
)