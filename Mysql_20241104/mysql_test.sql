-- webdb 데이터베이스 선택
USE webdb;

-- member 테이블 생성
CREATE TABLE member (
    member_id CHAR(8) NOT NULL,  -- 회원 ID
    member_name CHAR(5) NOT NULL, -- 회원 이름
    member_addr CHAR(20) NOT NULL  -- 회원 주소
);

-- member_id를 기본 키로 설정
ALTER TABLE member
ADD CONSTRAINT pk_member_id PRIMARY KEY (member_id);

-- product 테이블 생성
CREATE TABLE product (
    product_name CHAR(4) NOT NULL, -- 제품 이름
    cost INT NOT NULL,              -- 제품 가격
    make_date DATE NOT NULL,        -- 제조 날짜
    company CHAR(5) NOT NULL,       -- 제조 회사
    amount INT NOT NULL,            -- 재고 수량
    PRIMARY KEY (product_name)      -- 제품 이름을 기본 키로 설정
);

-- member 테이블의 모든 데이터 조회
SELECT * FROM member;

-- member 테이블에 데이터 삽입
INSERT INTO member (member_id, member_name, member_addr) 
VALUES ('tess', '나훈아', '경기도 부천시 중동');

INSERT INTO member (member_id, member_name, member_addr) 
VALUES ('hero', '아이유', '인천 남구 주안동');

INSERT INTO member (member_id, member_name, member_addr) 
VALUES ('iyou', '임영웅', '서울 은평구 증안동');

INSERT INTO member (member_id, member_name, member_addr) 
VALUES ('jpy', '박진영', '경기 고양시 장항동');

INSERT INTO member (member_id, member_name, member_addr) 
VALUES ('carray', '머라이어', '미국 텍사스주 사막');

-- carray의 주소 업데이트
UPDATE member
SET member_addr = '영국 런던 먹자골목'
WHERE member_id = 'carray';

-- member_id가 'carray'인 회원 삭제
DELETE FROM member
WHERE member_id = 'carray';

------------------------------------------------
-- product2 테이블의 모든 데이터 조회 (product2 테이블이 생성되어야 함)
SELECT * FROM product2;

-- product2 테이블에 데이터 삽입
INSERT INTO product2 (product_name, cost, make_date, company, amount) 
VALUES ('바나나', '1500', '2021-07-01', '델몬트', '17');

INSERT INTO product2 (product_name, cost, make_date, company, amount) 
VALUES ('카스', '2500', '2022-03-01', 'OB', '3');

-- product 테이블에 데이터 삽입
INSERT INTO product (product_name, cost, make_date, company, amount) 
VALUES ('삼각김밥', '800', '2023-09-01', 'CJ', '22');

---------------------------------------------------------

-- produc2t 테이블 생성 (잘못된 문법 포함, 수정 필요)
CREATE TABLE produc2t (
    product_name CHAR(4) NOT NULL,  -- 제품 이름
    cost INT NOT NULL,               -- 제품 가격
    make_date DATE DEFAULT CURRENT_DATE, -- 제조 날짜 (기본값 현재 날짜)
    company CHAR(5),                 -- 제조 회사
    amount INT NOT NULL,             -- 재고 수량
    PRIMARY KEY (product_name)       -- 제품 이름을 기본 키로 설정
);

-- product2 테이블 생성
CREATE TABLE product2 (
    product_name CHAR(4) NOT NULL,  -- 제품 이름
    cost INT NOT NULL,               -- 제품 가격
    make_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 제조 날짜 (기본값 현재 타임스탬프)
    company CHAR(5) NOT NULL,        -- 제조 회사
    amount INT NOT NULL,             -- 재고 수량
    PRIMARY KEY (product_name)       -- 제품 이름을 기본 키로 설정
);
