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

INSERT INTO tb_tide_observation_post (post_id, post_name, category)
VALUES ('DT_0001', '인천', 'DT'),
       ('DT_0002', '평택', 'DT'),
       ('DT_0003', '영광', 'DT'),
       ('DT_0004', '제주', 'DT'),
       ('DT_0005', '부산', 'DT'),
       ('DT_0006', '묵호', 'DT'),
       ('DT_0007', '목포', 'DT'),
       ('DT_0008', '안산', 'DT'),
       ('DT_0010', '서귀포', 'DT'),
       ('DT_0011', '후포', 'DT'),
       ('DT_0012', '속초', 'DT'),
       ('DT_0013', '울릉도', 'DT'),
       ('DT_0014', '통영', 'DT'),
       ('DT_0016', '여수', 'DT'),
       ('DT_0017', '대산', 'DT'),
       ('DT_0018', '군산', 'DT'),
       ('DT_0020', '울산', 'DT'),
       ('DT_0021', '추자도', 'DT'),
       ('DT_0022', '성산포', 'DT'),
       ('DT_0023', '모슬포', 'DT'),
       ('DT_0024', '장항', 'DT'),
       ('DT_0025', '보령', 'DT'),
       ('DT_0026', '고흥발포', 'DT'),
       ('DT_0027', '완도', 'DT'),
       ('DT_0028', '진도', 'DT'),
       ('DT_0029', '거제도', 'DT'),
       ('DT_0031', '거문도', 'DT'),
       ('DT_0032', '강화대교', 'DT'),
       ('DT_0035', '흑산도', 'DT'),
       ('DT_0036', '대청도', 'DT'),
       ('DT_0037', '어청도', 'DT'),
       ('DT_0038', '굴업도', 'DT'),
       ('DT_0039', '왕돌초', 'DT'),
       ('DT_0040', '독도', 'DT'),
       ('DT_0041', '복사초', 'DT'),
       ('DT_0042', '교본초', 'DT'),
       ('DT_0043', '영흥도', 'DT'),
       ('DT_0044', '영종대교', 'DT'),
       ('DT_0046', '쌍정초', 'DT'),
       ('DT_0047', '도농탄', 'DT'),
       ('DT_0048', '속초등표', 'DT'),
       ('DT_0049', '광양', 'DT'),
       ('DT_0050', '태안', 'DT'),
       ('DT_0051', '서천마량', 'DT'),
       ('DT_0052', '인천송도', 'DT'),
       ('DT_0054', '진해', 'DT'),
       ('DT_0056', '부산항신항', 'DT'),
       ('DT_0057', '동해항', 'DT'),
       ('DT_0058', '경인항', 'DT'),
       ('DT_0059', '백령도', 'DT'),
       ('DT_0060', '연평도', 'DT'),
       ('DT_0061', '삼천포', 'DT'),
       ('DT_0062', '마산', 'DT'),
       ('DT_0063', '가덕도', 'DT'),
       ('DT_0064', '교동대교', 'DT'),
       ('DT_0065', '덕적도', 'DT'),
       ('DT_0067', '안흥', 'DT'),
       ('DT_0068', '위도', 'DT'),
       ('DT_0091', '포항', 'DT'),
       ('DT_0092', '여호항', 'DT'),
       ('DT_0093', '소무의도', 'DT'),
       ('DT_0094', '서거차도', 'DT'),
       ('IE_0060', '이어도', 'IE'),
       ('IE_0061', '신안가거초', 'IE'),
       ('IE_0062', '옹진소청초', 'IE'),
       ('SO_0326', '미조항', 'SO'),
       ('SO_0537', '벽파진', 'SO'),
       ('SO_0538', '안마도', 'SO'),
       ('SO_0539', '강화외포', 'SO'),
       ('SO_0540', '호산항', 'SO'),
       ('SO_0547', '말도', 'SO'),
       ('SO_0548', '우이도', 'SO'),
       ('SO_0549', '초도', 'SO'),
       ('SO_0550', '나로도', 'SO'),
       ('SO_0551', '여서도', 'SO'),
       ('SO_0552', '고현항', 'SO'),
       ('SO_0553', '해운대', 'SO'),
       ('SO_0554', '영종왕산', 'SO'),
       ('SO_0555', '서망항', 'SO'),
       ('SO_0562', '승봉도', 'SO'),
       ('SO_0563', '울도', 'SO'),
       ('SO_0564', '국화도', 'SO'),
       ('SO_0565', '향화도항', 'SO'),
       ('SO_0566', '송공항', 'SO'),
       ('SO_0567', '쉬미항', 'SO'),
       ('SO_0568', '백야도', 'SO'),
       ('SO_0569', '남포항', 'SO'),
       ('SO_0570', '광암항', 'SO'),
       ('SO_0571', '거제외포', 'SO'),
       ('SO_0572', '읍천항', 'SO'),
       ('SO_0573', '양포항', 'SO'),
       ('SO_0574', '백사장항', 'SO'),
       ('SO_0576', '화봉리', 'SO'),
       ('SO_0577', '가거도', 'SO'),
       ('SO_0578', '소매물도', 'SO'),
       ('SO_0581', '강양항', 'SO'),
       ('SO_0631', '암태도', 'SO'),
       ('SO_0699', '천리포항', 'SO'),
       ('SO_0700', '호도', 'SO'),
       ('SO_0701', '홍도항', 'SO'),
       ('SO_0702', '진도옥도', 'SO'),
       ('SO_0703', '땅끝항', 'SO'),
       ('SO_0704', '소안항', 'SO'),
       ('SO_0705', '마량항', 'SO'),
       ('SO_0706', '청산도', 'SO'),
       ('SO_0707', '시산항', 'SO'),
       ('SO_0708', '안도항', 'SO'),
       ('SO_0709', '두문포', 'SO'),
       ('SO_0710', '봉우항', 'SO'),
       ('SO_0711', '창선도', 'SO'),
       ('SO_0712', '능양항', 'SO'),
       ('SO_0731', '대진항', 'SO'),
       ('SO_0732', '남애항', 'SO'),
       ('SO_0733', '강릉항', 'SO'),
       ('SO_0734', '궁촌항', 'SO'),
       ('SO_0735', '죽변항', 'SO'),
       ('SO_0736', '축산항', 'SO'),
       ('SO_0737', '강구항', 'SO'),
       ('SO_0739', '도장항', 'SO'),
       ('SO_0740', '보옥항', 'SO'),
       ('SO_0752', '검산항', 'SO'),
       ('SO_0753', '하의도웅곡', 'SO'),
       ('SO_0754', '평호리', 'SO'),
       ('SO_0755', '원동항', 'SO'),
       ('SO_0756', '사초항', 'SO'),
       ('SO_0757', '안남리', 'SO'),
       ('SO_0758', '달천도', 'SO'),
       ('SO_0759', '장문리', 'SO'),
       ('SO_0760', '오산항', 'SO'),
       ('SO_0761', '녹동항', 'SO'),
       ('SO_1248', '신안옥도', 'SO'),
       ('SO_1249', '독거도', 'SO'),
       ('SO_1250', '평도', 'SO'),
       ('SO_1251', '낙월도', 'SO'),
       ('SO_1252', '외연도항', 'SO'),
       ('SO_1253', '상왕등도', 'SO'),
       ('SO_1254', '만재도', 'SO'),
       ('SO_1255', '상태도', 'SO'),
       ('SO_1256', '어류정항', 'SO'),
       ('SO_1257', '강화하리', 'SO'),
       ('SO_1258', '잠진도', 'SO'),
       ('SO_1259', '자월도', 'SO'),
       ('SO_1260', '방포항', 'SO'),
       ('SO_1261', '무창포항', 'SO'),
       ('SO_1262', '격포항', 'SO'),
       ('SO_1263', '구시포항', 'SO'),
       ('SO_1264', '계마항', 'SO'),
       ('SO_1265', '송이도', 'SO'),
       ('SO_1266', '남열항', 'SO'),
       ('SO_1267', '구룡포항', 'SO'),
       ('SO_1268', '궁평항', 'SO'),
       ('SO_1269', '연도항', 'SO'),
       ('SO_1270', '삼길포항', 'SO'),
       ('SO_1271', '어은돌항', 'SO'),
       ('SO_1272', '다대포항', 'SO'),
       ('SO_1273', '장호항', 'SO'),
       ('SO_1274', '거진항', 'SO'),
       ('SO_1275', '공현진항', 'SO'),
       ('SO_1276', '아야진항', 'SO'),
       ('SO_1277', '화순항', 'SO'),
       ('SO_1278', '원평항', 'SO'),
       ('SO_1279', '어란진항', 'SO'),
       ('SO_1280', '덕산항', 'SO'),
       ('SO_1281', '임원항', 'SO'),
       ('SO_1282', '선재도', 'SO'),
       ('SO_1283', '사천진항', 'SO'),
       ('SO_1284', '월포리', 'SO'),
       ('SO_1285', '구계항', 'SO'),
       ('SO_1286', '영덕대진항', 'SO'),
       ('SO_1287', '구산항', 'SO'),
       ('SO_1288', '기사문항', 'SO'),
       ('SO_1289', '삼척항', 'SO');


-- 1. 서해 (인천 ~ 전남 목포/진도 라인)
UPDATE tb_tide_observation_post SET sea_zone = 'WEST'
WHERE post_name LIKE '%인천%' OR post_name LIKE '%평택%' OR post_name LIKE '%태안%'
   OR post_name LIKE '%보령%' OR post_name LIKE '%군산%' OR post_name LIKE '%목포%'
   OR post_name LIKE '%안산%' OR post_name LIKE '%강화%' OR post_name LIKE '%영종%'
   OR post_name LIKE '%대산%' OR post_name LIKE '%장항%' OR post_name LIKE '%진도%'
   OR post_id IN ('DT_0036', 'DT_0037', 'DT_0038', 'DT_0060', 'DT_0065', 'SO_1262', 'SO_1263');

-- 2. 남해 (전남 완도 ~ 부산 라인)
UPDATE tb_tide_observation_post SET sea_zone = 'SOUTH'
WHERE post_name LIKE '%완도%' OR post_name LIKE '%여수%' OR post_name LIKE '%통영%'
   OR post_name LIKE '%거제%' OR post_name LIKE '%부산%' OR post_name LIKE '%마산%'
   OR post_name LIKE '%진해%' OR post_name LIKE '%광양%' OR post_name LIKE '%고흥%'
   OR post_name LIKE '%삼천포%' OR post_name LIKE '%해운대%' OR post_name LIKE '%다대포%';

-- 3. 동해 (울산 ~ 강원 고성 라인)
UPDATE tb_tide_observation_post SET sea_zone = 'EAST'
WHERE post_name LIKE '%울산%' OR post_name LIKE '%포항%' OR post_name LIKE '%동해%'
   OR post_name LIKE '%속초%' OR post_name LIKE '%묵호%' OR post_name LIKE '%후포%'
   OR post_name LIKE '%울릉도%' OR post_name LIKE '%독도%' OR post_name LIKE '%강릉%'
   OR post_name LIKE '%삼척%' OR post_name LIKE '%죽변%' OR post_name LIKE '%구룡포%';

-- 4. 제주 (제주도 및 부속 도서)
UPDATE tb_tide_observation_post SET sea_zone = 'JEJU'
WHERE post_name LIKE '%제주%' OR post_name LIKE '%서귀포%' OR post_name LIKE '%성산%'
   OR post_name LIKE '%모슬포%' OR post_name LIKE '%추자도%' OR post_name LIKE '%화순항%'
   OR post_id IN ('DT_0021', 'DT_0022', 'DT_0023', 'IE_0060');



-- 1. 서해 (WEST) 보정
UPDATE fishing.tb_tide_observation_post
SET sea_zone = 'WEST'
WHERE sea_zone IS NULL AND (
    post_name LIKE '%신안%' OR post_name LIKE '%옹진%' OR post_name LIKE '%강화%' OR
    post_name LIKE '%영흥%' OR post_name LIKE '%서천%' OR post_name LIKE '%경인%' OR
    post_name LIKE '%백령%' OR post_name LIKE '%교동%' OR post_name LIKE '%소무의%' OR
    post_id IN ('DT_0003', 'DT_0043', 'DT_0058', 'DT_0059', 'DT_0064', 'DT_0067', 'DT_0068',
                'DT_0093', 'IE_0062', 'SO_0538', 'SO_0547', 'SO_0562', 'SO_0563', 'SO_0564',
                'SO_0565', 'SO_0566', 'SO_1251', 'SO_1252', 'SO_0753', 'SO_0757', 'SO_1256')
    );

-- 2. 남해 (SOUTH) 보정
UPDATE fishing.tb_tide_observation_post
SET sea_zone = 'SOUTH'
WHERE sea_zone IS NULL AND (
    post_name LIKE '%거문%' OR post_name LIKE '%가덕%' OR post_name LIKE '%여호%' OR
    post_name LIKE '%미조%' OR post_name LIKE '%나로%' OR post_name LIKE '%소매물%' OR
    post_name LIKE '%해남%' OR post_name LIKE '%완도%' OR post_name LIKE '%시산%' OR
    post_id IN ('DT_0031', 'DT_0063', 'DT_0092', 'DT_0094', 'SO_0326', 'SO_0549', 'SO_0550',
                'SO_0551', 'SO_0552', 'SO_0568', 'SO_0570', 'SO_0578', 'SO_0703', 'SO_0704',
                'SO_0705', 'SO_0707', 'SO_0708', 'SO_0709', 'SO_0711', 'SO_0752', 'SO_0761')
    );

-- 3. 동해 (EAST) 보정
UPDATE fishing.tb_tide_observation_post
SET sea_zone = 'EAST'
WHERE sea_zone IS NULL AND (
    post_name LIKE '%왕돌%' OR post_name LIKE '%복사%' OR post_name LIKE '%교본%' OR
    post_name LIKE '%쌍정%' OR post_name LIKE '%도농%' OR post_name LIKE '%호산%' OR
    post_name LIKE '%읍천%' OR post_name LIKE '%강양%' OR post_name LIKE '%대진%' OR
    post_id IN ('DT_0039', 'DT_0041', 'DT_0042', 'DT_0046', 'DT_0047', 'SO_0540', 'SO_0572',
                'SO_0581', 'SO_0731', 'SO_0732', 'SO_0734', 'SO_0736', 'SO_0737')
    );

-- 4. 제주 (JEJU) 보정
UPDATE fishing.tb_tide_observation_post
SET sea_zone = 'JEJU'
WHERE sea_zone IS NULL AND (
    post_name LIKE '%흑산%' OR post_name LIKE '%가거%' OR post_name LIKE '%상태%' OR
    post_id IN ('DT_0035', 'IE_0061', 'SO_0577', 'SO_1254', 'SO_1255')
    );



UPDATE tb_tide_observation_post
SET sea_zone = 'EAST'
WHERE post_id IN (
                  'SO_1274', 'SO_1275', 'SO_1276', 'SO_1283', 'SO_1288',
                  'SO_1273', 'SO_1280', 'SO_1281', 'SO_1287', 'SO_1285', 'SO_1284'
    );

-- 2. 서해 (WEST) - 경기/충남/전북 라인 (자월도, 궁평항, 선재도, 어은돌 등)
-- 자월도, 선재도, 궁평항, 어은돌항, 연도항, 상왕등도, 송이도, 계마항
UPDATE tb_tide_observation_post
SET sea_zone = 'WEST'
WHERE post_id IN (
                  'SO_1259', 'SO_1282', 'SO_1268', 'SO_1271', 'SO_1269',
                  'SO_1253', 'SO_1265', 'SO_1264'
    );

-- 3. 남해 (SOUTH) - 전남 남부 라인 (어란진, 원평항, 남열항)
-- 어란진항(해남), 원평항(신안/진도 인근 남해안), 남열항(고흥)
UPDATE tb_tide_observation_post
SET sea_zone = 'SOUTH'
WHERE post_id IN (
                  'SO_1279', 'SO_1278', 'SO_1266'
    );


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