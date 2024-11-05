-- 사용하려는 데이터베이스 선택
use market_db;

-- 첫 번째 테이블 hongong1 생성
create table hongong1(
    toy_id int,                  -- 장난감 ID (정수형)
    toy_name char(4),             -- 장난감 이름 (4글자 고정 길이 문자)
    age int                       -- 장난감 연령대 (정수형)
);    

-- 테이블 내용 조회
select * from hongong1;

-- 테이블에 데이터 삽입 (toy_id, toy_name, age)
insert into hongong1 values(1, '우디', 25);

-- toy_id와 toy_name만 지정하여 데이터 삽입 (age는 NULL로 자동 삽입됨)
insert into hongong1(toy_id, toy_name) values(2, '버즈');

-- 두 번째 테이블 hongong2 생성
create table hongong2(
    toy_id int auto_increment primary,   -- auto_increment를 사용하여 toy_id 자동 증가
    toy_name char(4),                    -- 장난감 이름 (4글자 고정 길이 문자)
    age int                              -- 장난감 연령대 (정수형)
); 

-- 테이블 내용 조회
select * from hongong2;

-- 데이터 삽입 (toy_name과 age만 지정, toy_id는 자동으로 증가)
insert into hongong2(toy_name, age) values('보핍', 25);
insert into hongong2(toy_name, age) values('슬랭키', 22);
insert into hongong2(toy_name, age) values('렉스', 21);

-- auto_increment 값을 100으로 설정
alter table hongong2 auto_increment=100;

-- toy_name과 age만 지정하여 데이터 삽입 (toy_id는 자동으로 100부터 시작)
insert into hongong2(toy_name, age) values('재남', 35);

-- 세 번째 테이블 hongong3 생성
create table hongong3(
    toy_id int auto_increment primary key,  -- auto_increment로 toy_id 자동 증가
    toy_name char(4),                       -- 장난감 이름 (4글자 고정 길이 문자)
    age int                                 -- 장난감 연령대 (정수형)
);

-- auto_increment 값을 1000으로 설정
alter table hongong3 auto_increment=1000;

-- auto_increment의 증가 값을 3으로 설정
set @@auto_increment_increment=3;

-- 데이터 삽입 (toy_name과 age만 지정, toy_id는 자동으로 증가)
insert into hongong3(toy_name, age) values('토마스', 20);
insert into hongong3(toy_name, age) values('제임스', 23);
insert into hongong3(toy_name, age) values('고든', 25);

-- 테이블 내용 조회
select * from hongong3;

-- 현재 auto_increment_increment 값 확인
select @@auto_increment_increment;
