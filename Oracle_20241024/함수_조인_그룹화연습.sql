--job_id가 IT_PROG라면 employee_id, frist_name, last_name,salary를 출력하되
-- salary가 9000이상이면 '상위 급여',6000과 8999사이이면 '중위 급여'
--그외에는 '하위급여'라고 입력
--case문
SELECT employee_id, first_name, last_name, salary,
    CASE
       WHEN salary >= 9000 THEN '상위 급여'
       WHEN salary BETWEEN 6000 AND 8999 THEN '중위 급여'
       ELSE '하위 급여'
    END AS 급여등급     
FROM employees
WHERE job_id = 'IT_PROG';

--RANK,DENSE_RANK,ROW_NUMBER 함수를 각각 이용해
--employees 테이블의 salary 값이 높은 순서대로 순위를 출력

-- 순의 매기기 (3가지 종류 구분)

select employee_id,
       salary,
       rank()       over(order by salary desc)rank_급여,
       dense_rank() over(order by salary desc)dense_rank_급여,
       row_number() over(order by salary desc)row_rank_급여
from employees;    

--salary의 합계와 평균을 구하고 avg를 사용하지 말고 평균 출력
--그룹 함수
select sum (salary) 합계,avg (salary) 평균, sum (salary)/count(salary)계산된_평균
from employees;
--salary의 최대값과 최솟값 그리고 first_name의 최대값,최소값 출력
select max (salary) 최대값, min (salary) 최소값, max (first_name)최대문자
from employees;


select max (salary) 최대값, min (salary) 최소값, min (first_name)최소문자
from employees;
--그룹화
--employees_id 가 10 10인상인 직원에 대해 job_id별로 그룹화 하여 job_id별 총 급여와 job_id
--별 총 급여와 job_id별 평균 급여를 구하고 job_id별 총급을 기준으로 내림차순 정렬
select job_id 직무,sum(salary)직무별_총급여,avg(salary)직무별_평균급여
from employees
where employee_id >=10
group by job_id
order by 직무별_총급여 desc, 직무별_평균급여;
--그룹화(조건-having)
--employees_id 가 10 10인상인 직원에 대해 job_id별로 그룹화 하여 job_id별 총 급여와 job_id
--별 총 급여와 job_id별 총 급여가 30000보다 큰 값만 출력
--출력 결과는 job_id별 총 급여를 기준으로 내림차순
select job_id 직무,sum(salary)직무별_총급여,avg(salary)직무별_평균급여
from employees
where employee_id >=10
group by job_id
having sum (salary)>30000
order by 직무별_총급여 desc, 직무별_평균급여;
--****조인
--동등 조인
SELECT a.employee_id, a.department_id, b.department_name, c.location_id, c.city
FROM employees A, departments B, locations C
WHERE A.department_id = B.department_id
AND B.location_id = C.location_id;
--외부 조인
SELECT a.employee_id, a.first_name, a.last_name, b.department_name, c.location_id, c.city
FROM employees A
LEFT JOIN departments B ON A.department_id = B.department_id
LEFT JOIN locations C ON B.location_id = C.location_id
ORDER BY A.department_id;
--자체 조인
select a.employee_id, a.first_name, a.last_name, a.manager_id, (b.first_name||''||b.last_name) manager_name
from employees A, employees B
WHERE a.manager_id=b.employee_id
order by a.employee_id;
--**집합 연산자
--합집합-UNION,UNIONALL
SELECT department_id
FROM employees
UNION
SELECT department_id
FROM employees;

--차집합-MINUS
SELECT department_id
FROM departments
MINUS
SELECT department_id
FROM employees;

--교집합-INTERSECT
SELECT department_id
FROM employees
INTERSECT
SELECT department_id
FROM employees
ORDER BY department_id;








