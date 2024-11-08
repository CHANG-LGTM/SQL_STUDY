-- 기존에 존재하는 프로시저 'user_proc'이 있으면 삭제
DROP PROCEDURE IF EXISTS user_proc;

-- 새로운 프로시저 'user_proc' 생성 (회원 테이블의 모든 정보를 조회하는 프로시저)
DELIMITER $$  -- 여러 줄의 SQL 명령어를 하나의 구분자($$)로 구분
CREATE PROCEDURE user_proc()
BEGIN
    SELECT * FROM member;  -- 회원 테이블의 모든 데이터를 조회
END $$
DELIMITER ;  -- 기본 구분자(;)로 되돌림

-- 'user_proc' 프로시저 호출 (회원 테이블의 모든 데이터 출력)
CALL user_proc();

-- 'user_proc' 프로시저 삭제
DROP PROCEDURE user_proc;


-- 기존에 존재하는 프로시저 'user_proc1'이 있으면 삭제
DROP PROCEDURE IF EXISTS user_proc1;

-- 'user_proc1' 프로시저 생성 (이름을 입력 받아 해당 회원의 정보를 조회하는 프로시저)
DELIMITER $$
CREATE PROCEDURE user_proc1(IN userName VARCHAR(10))
BEGIN
    SELECT * FROM member WHERE mem_name = userName;  -- 입력받은 'userName'에 해당하는 회원 정보 조회
END $$
DELIMITER ;

-- 'user_proc1' 프로시저 호출 (회원 이름이 '에이핑크'인 회원 정보 조회)
CALL user_proc1('에이핑크');

-- 'user_proc1' 프로시저 삭제
DROP PROCEDURE IF EXISTS user_proc1;


-- 기존에 존재하는 프로시저 'user_proc3'이 있으면 삭제
DROP PROCEDURE IF EXISTS user_proc3;

-- 'user_proc3' 프로시저 생성 (입력값을 'noTable' 테이블에 삽입하고, 삽입된 마지막 ID를 출력 변수로 반환)
DELIMITER $$
CREATE PROCEDURE user_proc3(
    IN txtValue VARCHAR(10),  -- 입력값: 텍스트
    OUT outValue INT          -- 출력값: 삽입된 데이터의 ID (출력 매개변수)
)
BEGIN
    -- 입력값을 'noTable' 테이블에 삽입
    INSERT INTO noTable VALUES (NULL, txtValue);

    -- 삽입된 데이터의 최대 ID 값을 출력 변수 'outValue'에 저장
    SELECT MAX(id) INTO outValue FROM noTable;
END $$
DELIMITER ;

-- 테이블 'noTable'이 존재하는지 확인
DESC notable;

-- 'noTable' 테이블이 없으면 생성
CREATE TABLE IF NOT EXISTS noTable (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- 자동 증가하는 ID (기본키)
    txt CHAR(10)                       -- 텍스트 데이터 저장
);

-- 'user_proc3' 프로시저 호출 (텍스트 '테스트1'을 삽입하고, 삽입된 ID를 변수에 저장)
CALL user_proc3('테스트1', @myvalue);

-- '@myvalue' 변수의 값 출력 (입력된 ID 값)
SELECT CONCAT('입력된 ID값==>', @myvalue);
