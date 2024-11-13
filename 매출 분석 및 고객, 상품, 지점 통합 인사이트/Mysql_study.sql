-- 전체 주문 정보 조회
select * from order_info;

-- 전체 주문 건수, 총 매출, 평균 매출, 최고 매출, 최저 매출 조회
select count(*) 전체주문건,
            sum(B.sales) 총매출,
            AVG(B.sales) 평균매출,
            MAX(B.sales) 최고매출,
            min(B.sales) 최저매출
from reservation A, order_info B
where A.reserv_no = B.reserv_no;

-- 예약 취소되지 않은 주문에 대한 총 판매량 및 매출 정보 조회
select count(*) 총판매량,
        sum(b.sales) 총매출,
        sum(decode(B.item_id,'M0001',1,0))전용상품판매량,
        sum(decode(B.item_id,'M0001',B.sales,0))전용상품매출
from reservation A, order_info B
where A.reserv_no = B.reserv_no
and A.cancel ='N';

-- 각 상품별 매출 조회 (전용상품 제외)
select C.item_id 상품아이디,
       C.product_name 상품이름,
       sum(B.sales) 상품매출
from reservation A,order_info B, item C
where a.reserv_no = b.reserv_no
and b.item_id = c.item_id
and a.cancel  ='N'
group by c.item_id, c.product_name
order by sum(b.sales) desc;

-- 매출 월별로 각 항목별 매출 정보 조회
SELECT substr(A.reserv_date,1,6) 매출월,
sum(decode(B.item_id,'M0001',B.sales,0))SPECIAL_SET,
sum(decode(B.item_id,'M0002',B.sales,0))PASTA,
sum(decode(B.item_id,'M0003',B.sales,0))PIZZA,
sum(decode(B.item_id,'M0004',B.sales,0))SEA_FOOD,   
sum(decode(B.item_id,'M0005',B.sales,0))STEAK,
sum(decode(B.item_id,'M0006',B.sales,0))SALAD_BAR,
sum(decode(B.item_id,'M0007',B.sales,0))SALAD,
sum(decode(B.item_id,'M0008',B.sales,0))SANDWICH,
sum(decode(B.item_id,'M0009',B.sales,0))WINE,
sum(decode(B.item_id,'M0010',B.sales,0))JUICE
from reservation A,order_info B
where A.reserv_no = B.reserv_no
and A.cancel = 'N'
group by substr(A.reserv_date,1,6)
order by substr(A.reserv_date,1,6);

-- 매출 월별로 전용상품과 기타 매출 정보 조회
select substr(A.reserv_date,1,6) 매출월,
    sum(B.sales) 총매출,
    sum(decode(B.item_id,'M0001',B.sales,0))전용상품매출
from reservation A, order_info B
where a.reserv_no = b.reserv_no
and A.cancel ='N'
group by substr(A.reserv_date,1,6)
order by substr(A.reserv_date,1,6);

-- 전용상품의 매출 비율, 예약 완료 및 취소 비율 조회
select substr(A.reserv_date,1,6) 매출월,
    sum(B.sales) 총매출,
    sum(B.sales)
    -sum(decode(b.item_id,'M0001',b.sales,0))전용상품외매출,
    sum(decode(b.item_id,'M0001',b.sales,0))전용상품매출,
    round(sum(decode(B.item_id,'M0001',B.sales,0))/sum(B.sales)*100,1)매출기여율
from reservation A, order_info B
where A.reserv_no = B.reserv_no
and A.cancel ='N'
group by substr(A.reserv_date,1,6)
order by substr(A.reserv_date,1,6);

-- 매출 월별로 예약 건수, 예약 취소율 등 다양한 정보를 조회
select substr(A.reserv_date,1,6) 매출월,
    sum(B.sales) 총매출,
    sum(B.sales)
    -sum(decode(B.item_id,'M0001',B.sales,0))전용상품외매출,
    sum(decode(B.item_id,'M0001',B.sales,0))전용상품매출,
    round(sum(decode(B.item_id,'M0001',B.sales,0))/sum(B.sales)*100,1)매출기여율,
    count(A.reserv_no) 총예약건,
    sum(decode(A.cancel,'N',1,0)) 예약완료건,
    sum(decode(A.cancel,'Y',1,0)) 예약취소건
from reservation A, order_info B
where A.reserv_no = B.reserv_no
-- and  A.cancel ='N'
group by substr(A.reserv_date,1,6)
order by substr(A.reserv_date,1,6);

-- 지점별 전용상품 매출 순위 조회 (순위가 1인 지점만 조회)
select *from
(
select substr(A.reserv_date,1,6) 매출월,
A.branch 지점,
sum(B.sales) 전용상품매출,
rank()over(partition by substr(a.reserv_date,1,6)
order by sum(B.sales)desc) 지점순위
 from reservation A, order_info B
        where A.reserv_no = B.reserv_no
        and A.cancel ='N'
        and B.item_id = 'M0001'
        group by substr (A.reserv_date,1,6),A.branch
        order by substr (A.reserv_date,1,6)
)A
where A.지점순위<=3;

-- 각 고객별 선호하는 상품 순위 조회
SELECT *
FROM (
    SELECT 
        A.고객아이디,
        A.고객이름,
        D.product_name AS 상품명,
        SUM(C.sales) AS 상품매출,
        RANK() OVER(PARTITION BY A.고객아이디 ORDER BY SUM(C.sales) DESC) AS 선호도순위
    FROM (
        -- 서브쿼리: 'M0001' 상품에 대해 216,000 이상 매출을 올린 고객을 찾는 부분
        SELECT 
            A.customer_id AS 고객아이디,
            A.customer_name AS 고객이름,
            SUM(C.sales) AS 전용상품_매출
        FROM customer A
        JOIN reservation B ON A.customer_id = B.customer_id
        JOIN order_info C ON B.reserv_no = C.reserv_no
        WHERE 
            B.cancel = 'N'
            AND C.item_id = 'M0001'
        GROUP BY A.customer_id, A.customer_name
        HAVING SUM(C.sales) >= 216000
    ) A
    JOIN reservation B ON A.고객아이디 = B.customer_id
    JOIN order_info C ON B.reserv_no = C.reserv_no
    JOIN item D ON C.item_id = D.item_id
    WHERE 
        D.item_id <> 'M0001' -- 'M0001' 상품은 제외
        AND B.cancel = 'N'
    GROUP BY A.고객아이디, A.고객이름, D.product_name
) A
WHERE A.선호도순위 = 1;

-- 고객의 주소별로 카운팅 (상위 10개 순위)
select A.주소,count(A.주소) 카운팅
from
(
select 
  A.customer_id 고객아이디,
  A.customer_name 고객이름,
  nvl(A.job,'정보없음') 직업,
  D.address_detail 주소,
  sum(C.sales) 전용상품_매출,
  rank() over(partition by C.item_id order by sum(C.sales)desc) 순위
from customer A, reservation B, order_info C,address D
where A.customer_id = B.customer_id
and B.reserv_no = C.reserv_no
and A.zip_code = D.zip_code
and B.cancel = 'N'
and C.item_id = 'M0001'
group by A.customer_id,C.item_id,A.customer_name, nvl(A.job,'정보없음'),
D.address_detail
)A
where A.순위<=10
group by A.주소
order by count(A.주소) desc;
