-- 프로시저 ifproc1이 존재하면 삭제
DROP PROCEDURE IF EXISTS ifProc1;

-- 구분자 변경 (프로시저 안에서 세미콜론을 사용하기 위해)
DELIMITER $$

-- 프로시저 ifproc1 생성
CREATE PROCEDURE ifproc1()
BEGIN
    -- 조건문: 100이 100과 같으면 '100은 100과 같습니다.'를 출력
    IF 100 = 100 THEN
        SELECT '100은 100과 같습니다.';
    END IF;
END $$

-- 구분자 복원 (세미콜론으로 변경)
DELIMITER ;

-- 프로시저 호출
CALL ifproc1();

-- 동일한 프로시저를 한 번 더 호출
CALL ifproc1();



-- 프로시저 ifproc2가 존재하면 삭제
DROP PROCEDURE IF EXISTS ifProc2;

-- 구분자 변경
DELIMITER $$

-- 프로시저 ifproc2 생성
CREATE PROCEDURE ifproc2()
BEGIN
    -- 변수를 선언하고 초기화
    DECLARE myNum INT;
    SET myNum = 200;

    -- 조건문: myNum이 100이면 '100입니다.'를 출력, 아니면 '100이 아닙니다.'를 출력
    IF myNum = 100 THEN
        SELECT '100입니다.';
    ELSE
        SELECT '100이 아닙니다.';
    END IF;
END $$

-- 구분자 복원
DELIMITER ;

-- 프로시저 호출
CALL ifproc2();



-- 프로시저 ifproc3이 존재하면 삭제
DROP PROCEDURE IF EXISTS ifProc3;

-- 구분자 변경
DELIMITER $$

-- 프로시저 ifproc3 생성
CREATE PROCEDURE ifproc3()
BEGIN
    -- 날짜 관련 변수를 선언
    DECLARE debutDate DATE;
    DECLARE curDate DATE;
    DECLARE days INT;
    
    -- debut_date를 market_db.member 테이블에서 APN 회원의 debut_date로 초기화
    SELECT debut_date INTO debutDate
    FROM market_db.member
    WHERE mem_id = 'APN';
    
    -- 현재 날짜를 curDate에 저장
    SET curDATE = CURRENT_DATE();
    
    -- debutDate와 curDate의 차이를 계산하여 'days' 변수에 저장
    SET days = DATEDIFF(curDate, debutDate);

    -- 조건문: 데뷔한지 5년 이상이면 축하 메시지를, 아니면 응원 메시지를 출력
    IF (days / 365) >= 5 THEN 
        SELECT CONCAT('데뷔한지 ', days, '일이나 지났습니다. 핑순이들 축하합니다!');
    ELSE
        SELECT CONCAT('데뷔한지 ', days, '일밖에 안되었네요. 핑순이들 화이팅~');
    END IF;
END $$

-- 구분자 복원
DELIMITER ;

-- 프로시저 호출
CALL ifproc3();
