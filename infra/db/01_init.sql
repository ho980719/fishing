CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE tb_tide_observation_post
(
    post_id    VARCHAR(20) PRIMARY KEY, -- DT_0001, SO_0326 등 코드
    post_name  VARCHAR(100) NOT NULL,   -- 인천, 평택 등 지명
    category   VARCHAR(10),             -- DT(표준), SO(격자/예보), IE(기지) 등 구분
    sea_zone   VARCHAR(10),             -- WEST(서해) / SOUTH(남해) / EAST(동해) / JEJU(제주)
    location   GEOGRAPHY(POINT, 4326),    -- 위경도 좌표
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE tb_tide_observation_post IS '전국 조석 관측소 및 예보지점 마스터 정보';
COMMENT ON COLUMN tb_tide_observation_post.post_id IS '관측소 고유 코드 (예: DT_0001, SO_0326)';
COMMENT ON COLUMN tb_tide_observation_post.post_name IS '지점 명칭 (예: 인천, 평택)';
COMMENT ON COLUMN tb_tide_observation_post.category IS '지점 구분 (DT:표준, SO:격자예보, IE:해양기지)';
COMMENT ON COLUMN tb_tide_observation_post.sea_zone IS '해역 구분 (WEST:서해, SOUTH:남해, EAST:동해, JEJU:제주)';
COMMENT ON COLUMN tb_tide_observation_post.location IS '위경도 좌표 데이터 (PostGIS Geography POINT)';
COMMENT ON COLUMN tb_tide_observation_post.created_at IS '데이터 생성 일시';

INSERT INTO tb_tide_observation_post (post_id, post_name, category, sea_zone, created_at) VALUES
-- 위치 검색으로 확인된 sea_zone
('SO_0537', '벽파진', 'SO', 'WEST', NOW()),   -- 전남 진도군, 서해어업관리단 관할
('SO_0548', '우이도', 'SO', 'WEST', NOW()),   -- 전남 신안군, 서해어업관리단 관할
('SO_0555', '서망항', 'SO', 'WEST', NOW()),   -- 전남 진도군 임회면, 서해어업관리단 관할
('SO_0567', '쉬미항', 'SO', 'WEST', NOW()),   -- 전남 진도군 진도읍
('SO_0576', '화봉리', 'SO', 'WEST', NOW()),   -- 전남 신안군
('SO_0631', '암태도', 'SO', 'WEST', NOW()),   -- 전남 신안군
('SO_0700', '호도', 'SO', 'WEST', NOW()),     -- 전남 신안군 흑산면
('SO_0701', '홍도항', 'SO', 'WEST', NOW()),   -- 전남 신안군 흑산면
('SO_0706', '청산도', 'SO', 'SOUTH', NOW()),  -- 전남 완도군, 남해 연안
('SO_0710', '봉우항', 'SO', 'SOUTH', NOW()),  -- 전남 완도군
('SO_0712', '능양항', 'SO', 'SOUTH', NOW()),  -- 전남 완도군
('SO_0740', '보옥항', 'SO', 'SOUTH', NOW()),  -- 전남 완도군
('SO_0754', '평호리', 'SO', 'WEST', NOW()),   -- 전남 신안군
('SO_0755', '원동항', 'SO', 'WEST', NOW()),   -- 전남 신안군
('SO_0756', '사초항', 'SO', 'WEST', NOW()),   -- 전남 신안군
('SO_0758', '달천도', 'SO', 'WEST', NOW()),   -- 전남 신안군
('SO_0759', '장문리', 'SO', 'WEST', NOW()),   -- 전남 신안군
('SO_0760', '오산항', 'SO', 'WEST', NOW()),   -- 전남 신안군 증도면
('SO_1249', '독거도', 'SO', 'SOUTH', NOW()),  -- 여수 남서쪽, 남해
('SO_1250', '평도', 'SO', 'SOUTH', NOW()),    -- 여수 남서쪽, 남해

-- EAST
('DT_0006', '묵호', 'DT', 'EAST', NOW()),
('DT_0011', '후포', 'DT', 'EAST', NOW()),
('DT_0012', '속초', 'DT', 'EAST', NOW()),
('DT_0013', '울릉도', 'DT', 'EAST', NOW()),
('DT_0020', '울산', 'DT', 'EAST', NOW()),
('DT_0040', '독도', 'DT', 'EAST', NOW()),
('DT_0048', '속초등표', 'DT', 'EAST', NOW()),
('DT_0057', '동해항', 'DT', 'EAST', NOW()),
('DT_0091', '포항', 'DT', 'EAST', NOW()),
('SO_0569', '남포항', 'SO', 'EAST', NOW()),
('SO_0573', '양포항', 'SO', 'EAST', NOW()),
('SO_0699', '천리포항', 'SO', 'EAST', NOW()),
('SO_0733', '강릉항', 'SO', 'EAST', NOW()),
('DT_0039', '왕돌초', 'DT', 'EAST', NOW()),
('DT_0041', '복사초', 'DT', 'EAST', NOW()),
('DT_0042', '교본초', 'DT', 'EAST', NOW()),
('DT_0046', '쌍정초', 'DT', 'EAST', NOW()),
('DT_0047', '도농탄', 'DT', 'EAST', NOW()),
('SO_0540', '호산항', 'SO', 'EAST', NOW()),
('SO_0572', '읍천항', 'SO', 'EAST', NOW()),
('SO_0581', '강양항', 'SO', 'EAST', NOW()),
('SO_0731', '대진항', 'SO', 'EAST', NOW()),
('SO_0732', '남애항', 'SO', 'EAST', NOW()),
('SO_0734', '궁촌항', 'SO', 'EAST', NOW()),
('SO_0735', '죽변항', 'SO', 'EAST', NOW()),
('SO_0736', '축산항', 'SO', 'EAST', NOW()),
('SO_0737', '강구항', 'SO', 'EAST', NOW()),
('SO_1273', '장호항', 'SO', 'EAST', NOW()),
('SO_1274', '거진항', 'SO', 'EAST', NOW()),
('SO_1275', '공현진항', 'SO', 'EAST', NOW()),
('SO_1276', '아야진항', 'SO', 'EAST', NOW()),
('SO_1280', '덕산항', 'SO', 'EAST', NOW()),
('SO_1281', '임원항', 'SO', 'EAST', NOW()),
('SO_1283', '사천진항', 'SO', 'EAST', NOW()),
('SO_1284', '월포리', 'SO', 'EAST', NOW()),
('SO_1285', '구계항', 'SO', 'EAST', NOW()),
('SO_1286', '영덕대진항', 'SO', 'EAST', NOW()),
('SO_1287', '구산항', 'SO', 'EAST', NOW()),
('SO_1288', '기사문항', 'SO', 'EAST', NOW()),
('SO_1260', '방포항', 'SO', 'EAST', NOW()),
('SO_1261', '무창포항', 'SO', 'EAST', NOW()),
('SO_1267', '구룡포항', 'SO', 'EAST', NOW()),
('SO_1270', '삼길포항', 'SO', 'EAST', NOW()),
('SO_1289', '삼척항', 'SO', 'EAST', NOW()),
('SO_1262', '격포항', 'SO', 'EAST', NOW()),
('SO_1263', '구시포항', 'SO', 'EAST', NOW()),
('SO_1272', '다대포항', 'SO', 'EAST', NOW()),

-- JEJU
('DT_0004', '제주', 'DT', 'JEJU', NOW()),
('DT_0010', '서귀포', 'DT', 'JEJU', NOW()),
('DT_0021', '추자도', 'DT', 'JEJU', NOW()),
('DT_0022', '성산포', 'DT', 'JEJU', NOW()),
('DT_0023', '모슬포', 'DT', 'JEJU', NOW()),
('IE_0060', '이어도', 'IE', 'JEJU', NOW()),
('DT_0035', '흑산도', 'DT', 'JEJU', NOW()),
('SO_0577', '가거도', 'SO', 'JEJU', NOW()),
('SO_1254', '만재도', 'SO', 'JEJU', NOW()),
('SO_1255', '상태도', 'SO', 'JEJU', NOW()),
('SO_1277', '화순항', 'SO', 'JEJU', NOW()),

-- WEST
('DT_0003', '영광', 'DT', 'WEST', NOW()),
('DT_0043', '영흥도', 'DT', 'WEST', NOW()),
('DT_0051', '서천마량', 'DT', 'WEST', NOW()),
('DT_0058', '경인항', 'DT', 'WEST', NOW()),
('DT_0059', '백령도', 'DT', 'WEST', NOW()),
('DT_0064', '교동대교', 'DT', 'WEST', NOW()),
('DT_0067', '안흥', 'DT', 'WEST', NOW()),
('DT_0068', '위도', 'DT', 'WEST', NOW()),
('DT_0093', '소무의도', 'DT', 'WEST', NOW()),
('IE_0061', '신안가거초', 'IE', 'WEST', NOW()),
('IE_0062', '옹진소청초', 'IE', 'WEST', NOW()),
('SO_0538', '안마도', 'SO', 'WEST', NOW()),
('SO_0547', '말도', 'SO', 'WEST', NOW()),
('SO_0562', '승봉도', 'SO', 'WEST', NOW()),
('SO_0563', '울도', 'SO', 'WEST', NOW()),
('SO_1256', '어류정항', 'SO', 'WEST', NOW()),
('DT_0001', '인천', 'DT', 'WEST', NOW()),
('DT_0002', '평택', 'DT', 'WEST', NOW()),
('DT_0007', '목포', 'DT', 'WEST', NOW()),
('DT_0008', '안산', 'DT', 'WEST', NOW()),
('DT_0017', '대산', 'DT', 'WEST', NOW()),
('DT_0018', '군산', 'DT', 'WEST', NOW()),
('DT_0024', '장항', 'DT', 'WEST', NOW()),
('DT_0025', '보령', 'DT', 'WEST', NOW()),
('DT_0028', '진도', 'DT', 'WEST', NOW()),
('DT_0032', '강화대교', 'DT', 'WEST', NOW()),
('DT_0036', '대청도', 'DT', 'WEST', NOW()),
('DT_0037', '어청도', 'DT', 'WEST', NOW()),
('DT_0038', '굴업도', 'DT', 'WEST', NOW()),
('DT_0044', '영종대교', 'DT', 'WEST', NOW()),
('DT_0050', '태안', 'DT', 'WEST', NOW()),
('DT_0052', '인천송도', 'DT', 'WEST', NOW()),
('DT_0060', '연평도', 'DT', 'WEST', NOW()),
('DT_0065', '덕적도', 'DT', 'WEST', NOW()),
('SO_0539', '강화외포', 'SO', 'WEST', NOW()),
('SO_0554', '영종왕산', 'SO', 'WEST', NOW()),
('SO_0574', '백사장항', 'SO', 'WEST', NOW()),
('SO_0702', '진도옥도', 'SO', 'WEST', NOW()),
('SO_0739', '도장항', 'SO', 'WEST', NOW()),
('SO_1257', '강화하리', 'SO', 'WEST', NOW()),
('SO_1258', '잠진도', 'SO', 'WEST', NOW()),
('SO_1253', '상왕등도', 'SO', 'WEST', NOW()),
('SO_0564', '국화도', 'SO', 'WEST', NOW()),
('SO_0565', '향화도항', 'SO', 'WEST', NOW()),
('SO_0566', '송공항', 'SO', 'WEST', NOW()),
('SO_0753', '하의도웅곡', 'SO', 'WEST', NOW()),
('SO_0757', '안남리', 'SO', 'WEST', NOW()),
('SO_1248', '신안옥도', 'SO', 'WEST', NOW()),
('SO_1251', '낙월도', 'SO', 'WEST', NOW()),
('SO_1252', '외연도항', 'SO', 'WEST', NOW()),
('SO_1259', '자월도', 'SO', 'WEST', NOW()),
('SO_1264', '계마항', 'SO', 'WEST', NOW()),
('SO_1265', '송이도', 'SO', 'WEST', NOW()),
('SO_1268', '궁평항', 'SO', 'WEST', NOW()),
('SO_1269', '연도항', 'SO', 'WEST', NOW()),
('SO_1271', '어은돌항', 'SO', 'WEST', NOW()),
('SO_1282', '선재도', 'SO', 'WEST', NOW()),

-- SOUTH
('DT_0005', '부산', 'DT', 'SOUTH', NOW()),
('DT_0014', '통영', 'DT', 'SOUTH', NOW()),
('DT_0016', '여수', 'DT', 'SOUTH', NOW()),
('DT_0026', '고흥발포', 'DT', 'SOUTH', NOW()),
('DT_0027', '완도', 'DT', 'SOUTH', NOW()),
('DT_0029', '거제도', 'DT', 'SOUTH', NOW()),
('DT_0049', '광양', 'DT', 'SOUTH', NOW()),
('DT_0054', '진해', 'DT', 'SOUTH', NOW()),
('DT_0056', '부산항신항', 'DT', 'SOUTH', NOW()),
('DT_0061', '삼천포', 'DT', 'SOUTH', NOW()),
('DT_0062', '마산', 'DT', 'SOUTH', NOW()),
('SO_0553', '해운대', 'SO', 'SOUTH', NOW()),
('SO_0571', '거제외포', 'SO', 'SOUTH', NOW()),
('DT_0031', '거문도', 'DT', 'SOUTH', NOW()),
('DT_0063', '가덕도', 'DT', 'SOUTH', NOW()),
('DT_0092', '여호항', 'DT', 'SOUTH', NOW()),
('DT_0094', '서거차도', 'DT', 'SOUTH', NOW()),
('SO_0326', '미조항', 'SO', 'SOUTH', NOW()),
('SO_0549', '초도', 'SO', 'SOUTH', NOW()),
('SO_0550', '나로도', 'SO', 'SOUTH', NOW()),
('SO_0551', '여서도', 'SO', 'SOUTH', NOW()),
('SO_0552', '고현항', 'SO', 'SOUTH', NOW()),
('SO_0568', '백야도', 'SO', 'SOUTH', NOW()),
('SO_0570', '광암항', 'SO', 'SOUTH', NOW()),
('SO_0578', '소매물도', 'SO', 'SOUTH', NOW()),
('SO_0703', '땅끝항', 'SO', 'SOUTH', NOW()),
('SO_0704', '소안항', 'SO', 'SOUTH', NOW()),
('SO_0705', '마량항', 'SO', 'SOUTH', NOW()),
('SO_0707', '시산항', 'SO', 'SOUTH', NOW()),
('SO_0708', '안도항', 'SO', 'SOUTH', NOW()),
('SO_0709', '두문포', 'SO', 'SOUTH', NOW()),
('SO_0711', '창선도', 'SO', 'SOUTH', NOW()),
('SO_0752', '검산항', 'SO', 'SOUTH', NOW()),
('SO_0761', '녹동항', 'SO', 'SOUTH', NOW()),
('SO_1266', '남열항', 'SO', 'SOUTH', NOW()),
('SO_1278', '원평항', 'SO', 'SOUTH', NOW()),
('SO_1279', '어란진항', 'SO', 'SOUTH', NOW());

-- tb_tide_forecast 테이블
CREATE TABLE tb_tide_forecast
(
    id            BIGSERIAL       NOT NULL,
    obs_post_id   VARCHAR(20)     NOT NULL,
    obs_post_name VARCHAR(255)    NOT NULL,
    forecast_dt   TIMESTAMP       NOT NULL,
    tide_level    INTEGER         NOT NULL,
    extr_se       INTEGER         NOT NULL,
    tide_type     VARCHAR(20)     NOT NULL,
    is_high_tide  BOOLEAN         NOT NULL,
    created_at    TIMESTAMP       NOT NULL DEFAULT NOW(),

    CONSTRAINT pk_tide_forecast PRIMARY KEY (id),
    CONSTRAINT uq_tide_forecast_post_dt UNIQUE (obs_post_id, forecast_dt)
);

-- 컬럼 코멘트
COMMENT ON TABLE  tb_tide_forecast                IS '조석 예보 정보';
COMMENT ON COLUMN tb_tide_forecast.id             IS 'PK';
COMMENT ON COLUMN tb_tide_forecast.obs_post_id    IS '관측소 코드 (tb_tide_observation_post.post_id FK)';
COMMENT ON COLUMN tb_tide_forecast.obs_post_name  IS '관측소명';
COMMENT ON COLUMN tb_tide_forecast.forecast_dt    IS '예측 일시 (yyyyMMddHHmm)';
COMMENT ON COLUMN tb_tide_forecast.tide_level     IS '예측 조위값 (cm)';
COMMENT ON COLUMN tb_tide_forecast.extr_se        IS '극치구분 코드 (1: 오전 고조, 2: 오전 저조, 3: 오후 고조, 4: 오후 저조)';
COMMENT ON COLUMN tb_tide_forecast.tide_type      IS '극치구분 설명 (오전 고조 / 오전 저조 / 오후 고조 / 오후 저조)';
COMMENT ON COLUMN tb_tide_forecast.is_high_tide   IS '만조 여부 (true: 만조, false: 간조)';
COMMENT ON COLUMN tb_tide_forecast.created_at     IS '생성일시';

-- 조회 성능용 인덱스
CREATE INDEX idx_tide_forecast_obs_post_id  ON tb_tide_forecast (obs_post_id);
CREATE INDEX idx_tide_forecast_forecast_dt  ON tb_tide_forecast (forecast_dt);