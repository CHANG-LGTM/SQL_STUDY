-- market_db 데이터베이스 선택
USE market_db;

-- member 테이블의 모든 데이터 조회
SELECT * FROM member;

-- member 테이블에서 주소, 데뷔일자, 이름 조회
SELECT addr 주소, debut_date 데뷔일자, mem_name FROM member;

-- 이름이 '블랙핑크'인 회원 조회
SELECT * FROM member WHERE mem_name='블랙핑크';

-- 회원 번호가 4인 회원 조회
SELECT * FROM member WHERE mem_number=4;

-- 키가 162 이하인 회원의 ID와 이름 조회
SELECT mem_id, mem_name FROM member WHERE height <= 162;

-- 키가 165 이상이고 회원 번호가 6보다 큰 회원 조회
SELECT mem_name, height, mem_number FROM member WHERE height >= 165 AND mem_number > 6;

-- 키가 165 이상이거나 회원 번호가 6보다 큰 회원 조회
SELECT mem_name, height, mem_number FROM member WHERE height >= 165 OR mem_number > 6;

-- 키가 163 이상 165 이하인 회원의 이름과 키 조회
SELECT mem_name, height FROM member WHERE height >= 163 AND height <= 165;

-- 키가 163 이상 165 이하인 회원 조회 (BETWEEN 사용)
SELECT mem_name, height FROM member WHERE height BETWEEN 163 AND 165;

-- 주소가 '경기', '전남', '경남'인 회원의 이름과 주소 조회
SELECT mem_name, addr FROM member WHERE addr = '경기' OR addr = '전남' OR addr = '경남';

-- 주소가 '경기', '전남', '경남' 중 하나인 회원 조회 (IN 사용)
SELECT mem_name, addr FROM member WHERE addr IN ('경기', '전남', '경남');

-- 이름이 '우'로 시작하는 회원 조회
SELECT * FROM member WHERE mem_name LIKE '우%';

-- '에이핑크'의 키 조회
SELECT height FROM member WHERE mem_name = '에이핑크';

-- 키가 164 이상인 회원의 이름과 키 조회
SELECT mem_name, height FROM member WHERE height > 164;

-- '에이핑크'보다 키가 큰 회원의 이름과 키 조회
SELECT mem_name, height FROM member WHERE height > (SELECT height FROM member WHERE mem_name = '에이핑크');

-- 데뷔일자를 기준으로 회원 ID, 이름, 데뷔일자 조회
SELECT mem_id, mem_name, debut_date FROM member ORDER BY debut_date;

-- 데뷔일자를 기준으로 내림차순으로 회원 조회
SELECT mem_id, mem_name, debut_date FROM member ORDER BY debut_date DESC;

-- 키가 164 이상인 회원의 ID, 이름, 데뷔일자, 키 조회 (내림차순)
SELECT mem_id, mem_name, debut_date, height FROM member WHERE height >= 164 ORDER BY height DESC;

-- 키가 164 이상인 회원 조회 (키 내림차순, 데뷔일자 오름차순)
SELECT mem_id, mem_name, debut_date, height FROM member WHERE height >= 164 ORDER BY height DESC, debut_date ASC;

-- 데뷔일자를 기준으로 첫 3명의 회원 이름과 데뷔일자 조회
SELECT mem_name, debut_date FROM member ORDER BY debut_date LIMIT 3;

-- 키를 기준으로 내림차순으로 3번째부터 2명의 회원 이름과 키 조회
SELECT mem_name, height FROM member ORDER BY height DESC LIMIT 3, 2;

-- 모든 회원의 주소 조회
SELECT addr FROM member;

-- 모든 회원의 주소를 정렬하여 조회
SELECT addr FROM member ORDER BY addr;

-- member 테이블에서 중복 없는 주소 조회
SELECT DISTINCT addr FROM member;

-- buy 테이블에서 회원 ID별로 총 구매 금액 정렬하여 조회
SELECT mem_id, amount FROM buy ORDER BY mem_id;

-- buy 테이블에서 회원 ID별로 총 구매 개수 조회
SELECT mem_id, SUM(amount) FROM buy GROUP BY mem_id;

-- buy 테이블에서 회원 ID와 총 구매 개수를 조회
SELECT mem_id '회원 아이디', SUM(amount) '총 구매 개수' FROM buy GROUP BY mem_id;

-- buy 테이블에서 회원 ID별로 총 구매 금액 조회
SELECT mem_id '회원 아이디', SUM(price * amount) '총 구매 금액' FROM buy GROUP BY mem_id;

-- buy 테이블에서 평균 구매 개수 조회
SELECT AVG(amount) '평균 구매 개수' FROM buy;

-- buy 테이블에서 회원 ID별 평균 구매 개수 조회
SELECT mem_id, AVG(amount) '평균 구매 개수' FROM buy GROUP BY mem_id;

-- member 테이블의 전체 회원 수 조회
SELECT COUNT(*) FROM member;

-- 연락처가 있는 회원 수 조회
SELECT COUNT(phone1) '연락처가 있는 회원' FROM member;

-- buy 테이블에서 회원 ID별로 총 구매 금액 조회
SELECT mem_id '회원 아이디', SUM(price * amount) '총 구매 금액' FROM buy GROUP BY mem_id;

-- 총 구매 금액이 1000 이상인 회원 조회
SELECT mem_id '회원 아이디', SUM(price * amount) '총 구매 금액' FROM buy GROUP BY mem_id HAVING SUM(price * amount) > 1000;

-- 총 구매 금액이 1000 이상인 회원을 금액 기준으로 내림차순 정렬하여 조회
SELECT mem_id '회원 아이디', SUM(price * amount) '총 구매 금액' FROM buy GROUP BY mem_id HAVING SUM(price * amount) > 1000 ORDER BY SUM(price * amount) DESC;
