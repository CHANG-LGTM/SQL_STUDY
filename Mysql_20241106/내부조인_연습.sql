-- 내부조인
select * from buy 
inner join member
on buy.mem_id =member.mem_id 
where buy.mem_id ='BLK';

-- 내부조인 간결하게
select buy.mem_id, mem_name, prod_name, addr, concat(phone1,phone2) '연락처' 
from buy 
inner join member
on buy.mem_id =member.mem_id; , buy


-- 테이블 명을 약호로

select B.mem_id, M.mem_name,B.prod_name, M.addr, 
concat(M.phone1,M.phone2) '연락처' 
from buy B
inner join member M
on B.mem_id =M.mem_id; 
