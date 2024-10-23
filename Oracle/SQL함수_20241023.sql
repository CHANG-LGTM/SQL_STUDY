select *from employees;

--where
select *
from employees
where employee_id = 100;
--frist_name이 David인 직원의 정보
select *
from employees
where frist_name = 'David';

--employee_id가 105이상인 직원의 정보
select *
from employees
where employee_id >= 105;
--salary가 10,000이상이고 20,000이하인 직원의 정보
select *
from employees
where salary between 10000 and 20000;
--salary가 10,000, 17000,24000인 직원 정보

select *
from employees
where salary in(10000,17000,24000);

--job_id값이 AD로 시작하는 모든(%)데이터를 출력
select *
from employees
where job_id like 'AD%';
--AD로 시작하면서 뒤에 따라오는 문자열이 3자리인 데이터 출력
select *
from employees
where job_id like 'AD___';
--manager_id가 null값인 직원 정보
select *
from employees
where manager_id is null;

--논리 연산자
--salary가 4000을 초과하면서 job_id가 IT_PROG인 값을 조회
select *
from employees
where salary > 4000 AND job_id='IT_PROG';
--salary가 4000을 초과하면서 job_id가 IT_PROG 이거나 FI_ACCOUNT인 경우
select *
from employees
where salary > 4000 AND job_id='IT_PROG'
OR job_id='FI_ACCOUNT';
--employee_id가 105가 아닌 직원만 출력
select *
from employees
where employee_id <> 105;


-------------------------------------------------------
--SQL 함수
--last_name을 소문자와 대문자로 각각 출력하고, email을 첫 번째 문자는 대문자로 출력
SELECT last_name,
       LOWER(last_name) AS Lower_적용,
       UPPER(last_name) AS Upper_적용,
       email,
       INITCAP(email) AS Initcap_적용
FROM employees;


--특정 글자 출력
select job_id, substr(job_id,1,2)
from employees;
--글자 바꾸기(표시로 만)
select job_id, replace(job_id,'ACCOUNT','ACCNT') 적용결과
FROM employees;
--특정 문자로 채우기
--frist_name에 대해 12자리의 문자열 자리를 만들되 frist_name의 데이터 값이 12보다 작으면 왼쪽에서부터*을 채워 출력
select first_name, RPAD(first_name, 12, '*')
FROM employees;
--중간에 공백을 제외한 나머지 공백 제거
select '$tart' ||'  -space-   '||'end'
from dual;
-- 자리 올림
--salary를 30일로 나눈 후 나눈 값의 소수점 첫째자리, 소수점 둘째자리,정수 첫째자리에서 반올림 한 값을 출력
select salary,
       salary/30 일급,
       trunc (salary/30,0) 적용결과_0,
       trunc(salary/30,1) 적용결과_1,
       trunc (salary/30,-1) 적용결과_마이너스1
FROM employees;
--절삭
--salary를 30일로 나눈 후 나눈 값의 소수점 첫째자리, 소수점 둘째자리,정수 첫째자리에서 절삭하여 출력
SELECT salary / 30 AS 일급,
       ROUND(salary / 30, 0) AS 적용결과_0,
       ROUND(salary / 30, 1) AS 적용결과_1,
       ROUND(salary / 30, -1) AS 적용결과_마이너스1
FROM employees;

--날짜 계산 - 오늘 날짜, 더하기1,빼기1, 특정 날짜 빼기, 시간 더하기
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD/HH24:MI') AS 오늘_날짜,
       SYSDATE + 1 AS 더하기_1,
       SYSDATE - 1 AS 빼기_1,
       TO_DATE('2024-12-05', 'YYYY-MM-DD') - TO_DATE('2002-12-01', 'YYYY-MM-DD') AS 날짜빼기,
       SYSDATE + (13/24) AS 시간_더하기
FROM dual;

--두 날짜 사이에 개월 수 계산
select sysdate, hire_date, months_between(sysdate, hire_date) 적용결과      
FROM employees
where department_id = 100;
 
--월에 날짜 더하기 -ADD-MONTHS

select hire_date,  
        add_months(hire_date,3) 더하기_적용결과,
        add_months(hire_date,-3) 빼기_적용결과
FROM employees
where department_id = 100;
--null값 출력
select salary * commission_pct
FROM employees
order by commission_pct;
--DECODE 사용
select first_name,
        last_name,
        department_id,
        salary 원래_급여,
        decode(department_id,60,salary*1.1,salary) 조정된급여,
        decode(department_id,60,'10%인상','미인상') 인상여부
from employees;        






