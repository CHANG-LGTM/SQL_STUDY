select employee_id, frist_name, last_name
from employees;
--내림 차순 정렬--
select employee_id, frist_name, last_name
from employees
order by employee_id desc;

--job-id 출력--
select DISTINCT job_id
from employees;
--필드명 변경--
SELECT employee_id 사원번호, frist_name 이름, last_name 성
from employees;


--frist_name, last_name 같이 붙여서 출력--
select employee_id, frist_name||' '||last_name
from employees;

--email포함 출력
SELECT employee_id 사원번호, frist_name 이름, last_name 성,email||'@company'이메일
from employees;


