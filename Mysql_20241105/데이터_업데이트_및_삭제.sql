-- market_db 데이터베이스 사용
use market_db;

-- city_name이 'seoul'인 도시 조회
select * from city_popul where city_name = 'seoul';

-- 다시 market_db 데이터베이스 사용 (중복되지만 명시적으로 작성됨)
use market_db;

-- city_name이 'Seoul'인 도시의 이름을 '서울'로 업데이트
update city_popul
    set city_name = '서울'
    where city_name = 'Seoul';

-- city_name이 '서울'인 도시 조회
select * from city_popul where city_name = '서울';

-- city_name이 'New york'인 도시의 이름을 '뉴욕'으로 변경하고, 인구(population)를 0으로 업데이트
update city_popul
    set city_name = '뉴욕', population = 0
    where city_name = 'New york';

-- city_name이 'New'로 시작하는 도시 조회
select * from city_popul where city_name like 'New%';

-- city_name이 'New'로 시작하는 모든 도시 데이터 삭제
delete from city_popul 
where city_name like 'New%';
