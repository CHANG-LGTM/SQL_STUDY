-- 프로시저 caseProc가 존재하면 삭제
DROP PROCEDURE IF EXISTS caseProc;

-- 구분자 변경
DELIMITER $$

-- 프로시저 caseProc 생성
CREATE PROCEDURE caseProc()
BEGIN
    -- 변수 선언
    DECLARE point INT;
    DECLARE credit CHAR(1);

    -- 초기값 설정
    SET point = 88;

    -- 조건에 따른 학점 계산 (case문 사용)
    CASE
        WHEN point >= 90 THEN
            SET credit = 'A';
        WHEN point >= 80 THEN
            SET credit = 'B';
        WHEN point >= 70 THEN
            SET credit = 'C';
        WHEN point >= 60 THEN
            SET credit = 'D';
        ELSE
            SET credit = 'F';
    END CASE;

    -- 취득점수와 학점을 출력
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END $$

-- 구분자 복원
DELIMITER ;

-- 프로시저 호출
CALL caseProc();


-- 고객 등급을 계산하는 SQL 쿼리
SELECT M.mem_id, M.mem_name, SUM(price * amount) AS '총구매액',
    CASE
        WHEN (SUM(price * amount) >= 1500) THEN '최우수고객'
        WHEN (SUM(price * amount) >= 1000) THEN '우수고객'
        WHEN (SUM(price * amount) >= 1) THEN '일반고객'
        ELSE '유령고객'
    END AS '회원등급'
FROM buy B
    RIGHT OUTER JOIN member M
        ON B.mem_id = M.mem_id
GROUP BY M.mem_id
ORDER BY SUM(price * amount) DESC;





-- 프로시저 whileProc2가 존재하면 삭제
DROP PROCEDURE IF EXISTS whileProc2;

-- 구분자 변경
DELIMITER $$

-- 프로시저 whileProc2 생성
CREATE PROCEDURE whileProc2()
BEGIN
    -- 변수 선언
    DECLARE i INT;
    DECLARE hap INT;

    -- 초기값 설정
    SET i = 1;
    SET hap = 0;

    -- while문을 사용하여 1부터 100까지의 합 계산 (4의 배수 제외)
    mywhile:
    WHILE (i <= 100) DO
        -- 4의 배수일 경우 건너뛰기 (continue)
        IF (i % 4 = 0) THEN
            SET i = i + 1;
            ITERATE mywhile;  -- 4의 배수는 건너뛰고 다시 while문 처음으로 돌아감
        END IF;

        -- 합계 계산
        SET hap = hap + i;

        -- 합계가 1000을 넘으면 종료
        IF (hap > 1000) THEN
            LEAVE mywhile;  -- while문 종료
        END IF;

        -- i 증가
        SET i = i + 1;
    END WHILE;

    -- 계산된 합계 출력
    SELECT '1부터 100까지의 합(4의 배수 제외), 1000넘으면 종료==>', hap;
END $$

-- 구분자 복원
DELIMITER ;

-- 프로시저 호출
CALL whileProc2();
