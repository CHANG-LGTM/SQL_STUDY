-- 데이터베이스 선택
USE naver_db;

-- 회원 테이블 생성 (회원 정보 저장)
CREATE TABLE member (
    mem_id CHAR(8) PRIMARY KEY, -- 회원 ID (기본키)
    mem_name VARCHAR(10) NOT NULL, -- 회원 이름
    mem_number TINYINT NOT NULL, -- 회원 번호
    addr CHAR(2) NOT NULL, -- 회원 주소 (2글자)
    phone1 CHAR(3) NULL, -- 전화번호 앞자리
    phone2 CHAR(8) NULL, -- 전화번호 뒷자리
    height TINYINT UNSIGNED, -- 회원 키 (양수만 허용)
    debut_date DATE NULL -- 데뷔일자
);

-- 구매 테이블 생성 (구매 정보 저장)
CREATE TABLE buy (
    num CHAR(8) PRIMARY KEY, -- 구매 번호 (기본키)
    mem_id CHAR(8) PRIMARY KEY, -- 회원 ID (기본키, 복합키 사용)
    prod_name CHAR(6) NOT NULL, -- 상품명 (6글자)
    group_name CHAR(4) NULL, -- 그룹명 (4글자, NULL 허용)
    price INT UNSIGNED, -- 상품 가격 (양수만 허용)
    amount SMALLINT UNSIGNED -- 구매 수량 (양수만 허용)
);

-- 추가된 회원 테이블 생성 (회원의 ID, 이름, 이메일 저장)
CREATE TABLE members (
    mem_id CHAR(8) PRIMARY KEY, -- 회원 ID (기본키)
    name VARCHAR(100), -- 회원 이름
    email VARCHAR(100) -- 회원 이메일
);

-- 복합 기본 키로 설정된 구매 테이블 생성 (회원과 상품 구매 기록)
CREATE TABLE buy (
    num CHAR(8), -- 구매 번호
    mem_id CHAR(8), -- 회원 ID
    prod_name CHAR(6) NOT NULL, -- 상품명
    group_name CHAR(4) NULL, -- 그룹명
    price INT UNSIGNED, -- 가격
    amount SMALLINT UNSIGNED, -- 수량
    PRIMARY KEY (num, mem_id), -- 복합 기본키 (num, mem_id)
    FOREIGN KEY (mem_id) REFERENCES members(mem_id) -- 외래키 제약 (members 테이블과 연관)
);

-- 회원 정보 삽입
INSERT INTO member(mem_id, mem_name, mem_number, addr, phone1, phone2, height, debut_date)
VALUES
('TWC','트와이스','9','서울','02','1313213','156','2015.10.19'),
('BLK','블랙핑크','4','경남','055','1222222','163','2016.08.08'),
('AWF','여자친구','6','경기','031','3333333','165','2015.01.15');

-- members 테이블 삭제
DROP TABLE members;

-- 구매 테이블 조회
SELECT * FROM buy;

-- 구매 테이블을 자동 증가하는 숫자로 다시 생성
DROP TABLE IF EXISTS buy;
CREATE TABLE buy (
    num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 자동 증가 번호 (기본키)
    mem_id CHAR(8) NOT NULL, -- 회원 ID
    prod_name CHAR(6) NOT NULL -- 상품명
);

-- 뷰 생성: 회원의 ID, 이름, 주소를 표시하는 뷰
CREATE VIEW v_member AS
SELECT mem_id, mem_name, addr FROM member;

-- v_member 뷰 조회
SELECT * FROM v_member;

-- 특정 주소(서울, 경기)에 해당하는 회원 정보 조회
SELECT mem_name, addr FROM v_member
WHERE addr IN ('서울','경기');

-- 회원과 구매 정보를 결합한 뷰 생성
CREATE VIEW v_memberbuy AS
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr,
       CONCAT(M.phone1, M.phone2) AS '연락처'
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

-- '블랙핑크' 회원의 구매 내역 조회
SELECT * FROM v_memberbuy WHERE mem_name = '블랙핑크';

-- 회원과 구매 정보를 결합하여 출력하는 뷰 생성 (English format)
CREATE VIEW v_viewtest1 AS
SELECT B.mem_id AS 'Member_ID', M.mem_name AS 'Member Name', 
       B.prod_name AS 'Product_Name',
       CONCAT(M.phone1, M.phone2) AS 'Office phone'
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

-- v_viewtest1에서 'Member_ID'와 'Member Name' 컬럼만 조회
SELECT DISTINCT 'Member_ID', 'Member Name' FROM v_viewtest1;

-- 회원과 구매 정보를 결합하여 출력하는 뷰 생성 (Korean format)
CREATE VIEW v_viewtest1 AS
SELECT B.mem_id AS '회원 아이디', M.mem_name AS '회원 이름', 
       B.prod_name AS '제품 이름',
       CONCAT(M.phone1, M.phone2) AS '연락처'
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

-- v_viewtest1에서 '회원 아이디'와 '회원 이름' 컬럼만 조회
SELECT DISTINCT '회원 아이디', '회원 이름' FROM v_viewtest1;

-- v_viewtest2 뷰 생성 (회원 ID, 이름, 주소만 조회)
CREATE OR REPLACE VIEW v_viewtest2 AS
    SELECT mem_id, mem_name, addr FROM member;

-- v_viewtest2 테이블 구조 확인
DESCRIBE v_viewtest2;

-- 테이블 생성 예시: 두 개의 컬럼을 가진 테이블
CREATE TABLE table1 (
    col1 INT PRIMARY KEY, -- 기본키
    col2 INT, -- 데이터 컬럼
    col3 INT -- 데이터 컬럼
);

-- 테이블의 인덱스 확인
SHOW INDEX FROM table1;

-- 유니크 제약을 가진 테이블 생성
CREATE TABLE table2 (
    col1 INT PRIMARY KEY, -- 기본키
    col2 INT UNIQUE, -- 유니크 제약
    col3 INT UNIQUE -- 유니크 제약
);

-- 테이블의 인덱스 확인
SHOW INDEX FROM table2;

-- 테이블 삭제 예시
DROP TABLE IF EXISTS buy, member;

-- 회원 테이블 재생성
CREATE TABLE member (
    mem_id CHAR(8), -- 회원 ID
    mem_name VARCHAR(10), -- 회원 이름
    mem_number INT, -- 회원 번호
    addr CHAR(2) -- 주소
);

-- 회원 정보 삽입 예시
INSERT INTO member VALUES ('TWS','트와이스','9','서울');
INSERT INTO member VALUES ('BLK','블랙핑크','4','경남');
INSERT INTO member VALUES ('WMN','여자친구','6','경기');
INSERT INTO member VALUES ('OMY','오마이걸','7','서울');

-- 테이블에 기본키 추가
ALTER TABLE member
    ADD CONSTRAINT PRIMARY KEY(mem_id);

-- 기본키 제거 후 이름을 기준으로 기본키 추가
ALTER TABLE member 
    DROP PRIMARY KEY;
ALTER TABLE member   
    ADD CONSTRAINT PRIMARY KEY(mem_name);

-- 유니크 제약 추가
ALTER TABLE member
    ADD CONSTRAINT UNIQUE(mem_name);

-- 클러스터 테이블 생성 (클러스터 그룹 정보 저장)
CREATE TABLE cluster (
    mem_id CHAR(8), -- 회원 ID
    mem_name VARCHAR(10) -- 회원 이름
);

-- 클러스터 테이블에 데이터 삽입
INSERT INTO cluster VALUES('TWC','트와이스');
INSERT INTO cluster VALUES('BLK','블랙핑크');
INSERT INTO cluster VALUES('WMN','여자친구');
INSERT INTO cluster VALUES('OMY','오마이걸');
INSERT INTO cluster VALUES('GRL','소녀시대');
INSERT INTO cluster VALUES('ITZ','잇지');
INSERT INTO cluster VALUES('RED','레드벨벳');
INSERT INTO cluster VALUES('APN','에이핑크');
INSERT INTO cluster VALUES('SPC','우주소녀');
INSERT INTO cluster VALUES('MMU','마마무');

-- 클러스터 테이블 조회
SELECT * FROM cluster;

-- 클러스터 테이블에 기본키 추가
ALTER TABLE cluster
    ADD CONSTRAINT PRIMARY KEY(mem_id);

-- 두 번째 테이블 생성 예시
CREATE TABLE second (
    mem_id CHAR(8), -- 회원 ID
    mem_name VARCHAR(10) -- 회원 이름
);

-- 두 번째 테이블에 데이터 삽입
INSERT INTO second VALUES('TWC','트와이스');
INSERT INTO second VALUES('BLK','블랙핑크');
INSERT INTO second VALUES('WMN','여자친구');
INSERT INTO second VALUES('OMY','오마이걸');
INSERT INTO second VALUES('GRL','소녀시대');
INSERT INTO second VALUES('ITZ','잇지');
INSERT INTO second VALUES('RED','레드벨벳');
INSERT INTO second VALUES('APN','에이핑크');
INSERT INTO second VALUES('SPC','우주소녀');
INSERT INTO second VALUES('MMU','마마무');

-- 인덱스 생성: 회원 주소 기준 인덱스 추가
CREATE INDEX idx_member_addr ON member (addr);

-- 인덱스 생성: 회원 이름 기준 유니크 인덱스 추가
CREATE UNIQUE INDEX idx_member_mem_name ON member(mem_name);

-- 인덱스 삭제 예시
DROP INDEX idx_member_mem_name ON member;
