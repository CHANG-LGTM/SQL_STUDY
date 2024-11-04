-- webdb 데이터베이스 선택
USE webdb;

-- member 테이블의 모든 데이터 조회
SELECT * FROM member;

-- member 테이블에서 회원 이름과 주소 조회
SELECT member_name, member_addr FROM member;

-- 이름이 '아이유'인 회원 조회
SELECT * FROM member WHERE member_name = '아이유';

-- member_name 컬럼에 인덱스 생성
CREATE INDEX idx_member_name ON member(member_name);

-- member 테이블의 모든 데이터 조회 (인덱스 생성 후 성능 확인)
SELECT * FROM member;

-- 주소가 '경기'로 시작하는 회원 조회
SELECT * FROM member WHERE member_addr LIKE '경기%';

-- member_addr 컬럼에 인덱스 생성
CREATE INDEX idx_member_addr ON member(member_addr);

-- member 테이블의 특정 컬럼을 포함하는 뷰 생성
CREATE VIEW member_view AS
SELECT member_id, member_name, member_addr FROM member;

-- member_view의 모든 데이터 조회
SELECT * FROM member_view;

-- 또 다른 뷰 생성 (회원 ID와 이름만 포함)
CREATE VIEW member_name_view AS
SELECT member_id, member_name FROM member;

-- member_name_view의 모든 데이터 조회
SELECT * FROM member_name_view;
