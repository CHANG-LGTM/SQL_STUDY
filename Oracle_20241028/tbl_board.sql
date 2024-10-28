drop table tbl_board;
drop SEQUENCE seq_board;
drop index pk_board;


-- SEQUENCE 생성
CREATE SEQUENCE seq_board
    START WITH 1
    INCREMENT BY 1;

-- 테이블 생성
CREATE TABLE tbl_board (
    bno NUMBER(10, 0) PRIMARY KEY,  -- PRIMARY KEY 직접 정의
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    writer VARCHAR2(20) NOT NULL,    -- varchar2로 수정
    regdate DATE DEFAULT SYSDATE,
    updatedate DATE DEFAULT SYSDATE
);

insert into tbl_board(bno, title, content, writer)
        VALUES(seq_board.nextval, '테스트 제목','테스트 내용','user00');
        
        SELECT*from tbl_board;
SELECT * from tbl_board order by desc;

-- 기존 데이터를 복사하여 새 데이터 삽입
INSERT INTO tbl_board (bno, title, content, writer)
SELECT seq_board.NEXTVAL, title, content, writer
FROM tbl_board;

SELECT * from tbl_board order by bno desc;

SELECT * from tbl_board order by bno+1 desc;

--오라클 힌트
SELECT 
/*+ INDEX_DESC(tbl_board pk_board) */
*
from tbl_board
where bno>0;

SELECT 
/*+ FULL(tbl_board) */ * from tbl_board order by bno desc;

-- rownum으로 1페이지 보기
SELECT /*+ INDEX_DESC(tbl_board pk board)*/ ROWNUM rn, bno, title, content
FROM tbl_board where ROWNUM<=10;

--2페이지 보기
-- 머리속에만 있고 실제로는 안됨.
SELECT /*+ INDEX_DESC(tbl_board pk board)*/ ROWNUM rn, bno, title, content
FROM tbl_board where ROWNUM>10 and rownum<=20;
-- 해결방안
--1. 단계 : rownum은 반드시 1이 포함되도록 해야 한다.
SELECT /*+ INDEX_DESC(tbl_board pk board)*/ ROWNUM rn, bno, title, content
FROM tbl_board where rownum<=20;
--2. 단계 : 인라인 뷰를 사용
SELECT bno, title, content
from (SELECT /*+ INDEX_DESC(tbl_board pk board)*/ ROWNUM rn, bno, title, content
FROM tbl_board where rownum<=20)
where rn>10;

INSERT INTO boards (bno, btitle, bcontent, bwriter, bdate, bfilename, bfiledata)
VALUES (SEQ_BNO.NEXTVAL, '눈 오는 날', '함박눈이 내려요', 'winter', SYSDATE, 'snow.jpg', :binaryData);

String sql = 
    "INSERT INTO boards (bno, btitle, bcontent, bwriter, bdate, bfilename, bfiledata) " +
    "VALUES (SEQ_BNO.NEXTVAL, ?, ?, ?, SYSDATE, ?, ?)";
SELECT * FROM USER data;






