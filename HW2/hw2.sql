-- 데이터베이스 생성 및 지정
create database IF NOT EXISTS hotel_booking;
use hotel_booking;
alter database hotel_booking default character set utf8mb4;

set foreign_key_checks = 0;    			-- 외래키 체크하지 않는 것으로 설정
drop table IF EXISTS hotel cascade;   				-- 기존 hotel 테이블 제거
drop table IF EXISTS hotelier cascade;   			-- 기존 hotelier 테이블 제거
drop table IF EXISTS hotel_room cascade;   			-- 기존 hotel_room 테이블 제거
drop table IF EXISTS customer cascade;   			-- 기존 customer 테이블 제거
drop table IF EXISTS booking cascade;   			-- 기존 booking 테이블 제거 
drop table IF EXISTS stay_information cascade; 		-- 기존 stay_information 테이블 제거 
drop view IF EXISTS hongik_hotel_customers cascade; -- 기존 hongik_hotel_customers 뷰 제거
set foreign_key_checks = 1;   			-- 외래키 체크하는 것으로 설정


-- (1)  테이블 생성 
create table hotel (
    hid	varchar(20) not null,
    name varchar(20),
    pnumber varchar(20),
    address varchar(20),
    primary key(hid)
);

create table hotelier (
	hlid varchar(20) not null,
    name varchar(20),
    pnumber varchar(20),
    address varchar(20),
    hid varchar(20) not null,
    primary key(hlid),
    foreign key(hid) references hotel(hid)
);

create table hotel_room (
	hid	varchar(20) not null,
    rnumber varchar(20) not null,
    price int,
    primary key(hid, rnumber),
    check (price >= 0)
);

create table customer (
	cid	varchar(20) not null,
    name varchar(20),
    pnumber varchar(20),
    primary key(cid)
);

create table stay_information (
	cid varchar(20) not null,
    hid varchar(20) not null,
    rnumber varchar(20) not null,
    checkin date not null,
    checkout date,
    primary key(cid, hid, rnumber, checkin)
);

create table booking (
	cid varchar(20) not null,
    hid varchar(20) not null,
    rnumber varchar(20) not null,
    checkin date,
    checkout date,
    primary key(cid, hid, rnumber)
);

-- (2)  데이터 삽입 
-- hotel
insert into hotel(hid, name, address, pnumber)
values("H001", "홍익호텔", "마포구 상수동", "02-320-1234");
insert into hotel(hid, name, address, pnumber)
values("H002", "중앙호텔", "동작구 흑석동", "02-850-1234");
insert into hotel(hid, name, address, pnumber)
values("H003", "건국호텔", "광진구 자양동", "02-415-1234");

select * from hotel;

-- hotelier
insert into hotelier(hlid, name, hid)
values("HL001", "KMS", "H001");
insert into hotelier(hlid, name, hid)
values("HL002", "LED", "H001");
insert into hotelier(hlid, name, hid)
values("HL003", "YHD", "H002");
insert into hotelier(hlid, name, hid)
values("HL004", "KKT", "H002");
insert into hotelier(hlid, name, hid)
values("HL005", "CPC", "H003");
insert into hotelier(hlid, name, hid)
values("HL006", "LSY", "H003");

select * from hotelier;


-- hotel_room
insert into hotel_room(hid, rnumber, price)
values("H001", "01", 1400);
insert into hotel_room(hid, rnumber, price)
values("H001", "02", 1200);
insert into hotel_room(hid, rnumber, price)
values("H001", "03", 700);
insert into hotel_room(hid, rnumber, price)
values("H002", "01", 1900);
insert into hotel_room(hid, rnumber, price)
values("H002", "02", 1000);
insert into hotel_room(hid, rnumber, price)
values("H002", "03", 1300);
insert into hotel_room(hid, rnumber, price)
values("H002", "04", 1600);
insert into hotel_room(hid, rnumber, price)
values("H003", "01", 900);
insert into hotel_room(hid, rnumber, price)
values("H003", "02", 1100);

select * from hotel_room;

-- customer 
insert into customer(cid, name, pnumber)
values("C001", "PDN", "010-3304-6302");
insert into customer(cid, name, pnumber)
values("C002", "KYS", "010-7323-3789");
insert into customer(cid, name, pnumber)
values("C003", "YDJ", "010-2628-7436");
insert into customer(cid, name, pnumber)
values("C004", "KSM", "010-2299-7827");
insert into customer(cid, name, pnumber)
values("C005", "PJH", "010-3157-2501");
insert into customer(cid, name, pnumber)
values("C006", "HBC", "010-2936-5427");
insert into customer(cid, name, pnumber)
values("C007", "KCY", "010-7119-6732");
insert into customer(cid, name, pnumber)
values("C008", "PYS", "010-2523-9738");

select * from customer;

-- booking 
insert into booking(cid, hid, rnumber, checkin, checkout)
values("C001", "H001", "01", "2023/07/16", "2023/07/28");
insert into booking(cid, hid, rnumber, checkin, checkout)
values("C002", "H001", "02", "2023/07/21", "2023/07/22");
insert into booking(cid, hid, rnumber, checkin, checkout)
values("C001", "H002", "01", "2023/08/16", "2023/08/18");
insert into booking(cid, hid, rnumber, checkin, checkout)
values("C005", "H002", "01", "2023/09/06", "2023/09/09");
insert into booking(cid, hid, rnumber, checkin, checkout)
values("C005", "H002", "02", "2023/09/10", "2023/09/18");
insert into booking(cid, hid, rnumber, checkin, checkout)
values("C003", "H002", "02", "2023/09/14", "2023/10/17");
insert into booking(cid, hid, rnumber, checkin, checkout)
values("C002", "H002", "03", "2023/10/16", "2023/10/18");
insert into booking(cid, hid, rnumber, checkin, checkout)
values("C008", "H003", "01", "2023/10/22", "2023/10/26");
insert into booking(cid, hid, rnumber, checkin, checkout)
values("C004", "H003", "01", "2023/10/28", "2023/11/02");
insert into booking(cid, hid, rnumber, checkin, checkout)
values("C003", "H003", "02", "2023/10/29", "2023/11/03");

select * from booking;

-- stay_information 
insert into stay_information(cid, hid, rnumber, checkin, checkout)
values("C002", "H002", "01", "2021/07/16", "2021/07/20");
insert into stay_information(cid, hid, rnumber, checkin, checkout)
values("C001", "H003", "02", "2021/07/21", "2021/07/25");
insert into stay_information(cid, hid, rnumber, checkin, checkout)
values("C001", "H001", "01", "2021/08/16", "2021/08/28");
insert into stay_information(cid, hid, rnumber, checkin, checkout)
values("C004", "H002", "02", "2021/09/06", "2021/09/18");
insert into stay_information(cid, hid, rnumber, checkin, checkout)
values("C001", "H002", "02", "2021/09/10", "2021/09/17");
insert into stay_information(cid, hid, rnumber, checkin, checkout)
values("C003", "H002", "02", "2021/09/14", "2021/09/21");
insert into stay_information(cid, hid, rnumber, checkin, checkout)
values("C002", "H001", "03", "2022/10/15", "2022/10/24");
insert into stay_information(cid, hid, rnumber, checkin, checkout)
values("C005", "H003", "01", "2022/10/19", "2022/10/26");
insert into stay_information(cid, hid, rnumber, checkin, checkout)
values("C004", "H002", "01", "2022/10/22", "2022/10/26");
insert into stay_information(cid, hid, rnumber, checkin, checkout)
values("C005", "H003", "02", "2022/10/29", "2022/11/01");

select * from stay_information;

-- (3) 1)
select "1)";      
select * from hotel;
select * from hotelier;
select * from hotel_room;
select * from customer;
select * from booking;
select * from stay_information;

-- (3) 2) id가 H001인 호텔에서 근무하는 호텔리어의 ID와 이름 검색 
select "2)";
select hlid, name
from hotelier
where hid="H001";


-- (3) 3) 고객별로 자신이 투숙했던 모든 호텔별 투숙 일 수 합 검색 (night)
select "3)";

select cid, hid, sum(datediff(checkout, checkin)) as "투숙일수 합"
from stay_information
group by cid, hid;


-- (3) 4) 호텔 예약 중 예약한 일(night) 수가 4일 미만인 예약 정보에 대해 고객 이름과 호텔 이름
select "4)";
select customer.name, booking.hid
from booking, customer
where booking.cid = customer.cid and datediff(booking.checkout, booking.checkin) < 4;


-- (3) 5) ID가 "C001"인 고객이 투숙한 총 일수 
select "5)";
select sum(datediff(checkout, checkin)) as "투숙한 총 일 수"
from stay_information
where cid = "C001";

-- (3) 6) 가격이 1300원 이상인 호텔방을, 호텔 id에 대해 내림차순으로 / 호실에 대해 오름차순으로 
select "6)";
select hid, rnumber
from hotel_room
where price >= 1300
order by hid desc, rnumber asc;

-- (3) 7) 가장 오래전의 투숙 정보를 보유 중인 호텔의 이름과 전화번호
select "7)";
 select name, pnumber
 from hotel
 where hid = (select hid
			  from stay_information
              where checkin = (select min(checkin)
							   from stay_information));
           
-- 8) ID가 ‘H003’인 호텔이 보유하고 있는 호텔방을 예약한 적이 있는 고객의 이름
select "8)";
                  
select name
from customer 
where cid in (select cid
				from booking
				where rnumber in (select rnumber 
								from hotel_room
								where hid = "H003"));
		
-- 9) 체크인날짜가 2021년인 투숙정보를 2개 이상 보유중인 호텔의 이름 
select "9)";

select name
from hotel
where hid in (select hid
			  from stay_information
              where date_format(checkin, "%Y") like "%2021%"
              group by hid
              having count(*) >= 2);

-- 10) 2022년 8월 30일 이전에 체크인해서 투숙했던 정보 중에서 주소가 ‘흑석동’인 호텔을 예약했던 고객의 이름과 전화번호
select "10)";

select name, pnumber
from customer
where cid in (select distinct cid
			from stay_information 
            where checkin < "2022/08/30" and hid in (select hid 
													from hotel
                                                    where address like "%흑석동%"));
       

-- 11) ID가 ‘H001’과 ‘H002’인 호텔을 모두 예약한 적이 있는 고객의 이름
select "11)";

select name 
from customer
where cid in (select cid
			from booking
            where hid = "H001" or hid = "H002");
       
       
-- 12) 호텔별로 총 예약 수와 투숙 수
select "12)";

select booking.hid, count(booking.cid) as " 예약수", (select count(stay_information.cid) 
													from stay_information 
                                                    where stay_information.hid = booking.hid) as "투숙수"
from booking
group by booking.hid;

-- 13) ID가 ‘C002’인 고객이 예약한 호텔방의 가격을 모두 100원씩 증가

select "13)";
update hotel_room
set price = price + 100
where (hid, rnumber) in (select hid, rnumber
			   		   from booking
					   where cid = "C002");

select * from hotel_room;

-- 14) 중앙호텔’에 근무하는 모든 호텔리어들을 삭제 / + ‘호텔리어’ 테이블의 모든 레코드를 검색하는 select 문을 추가
select "14)";
delete
from hotelier
where hid in (select hid 
			  from hotel
              where name = "중앙호텔");

select * from hotelier;

-- 15) ‘홍익호텔’에 투숙한 경험이 있는 모든 고객들의 ID, 이름 및 전화번호 정보로 “hongik_hotel_customers” 이름의 뷰 생성 / 마지막에 해당 뷰의 모든 레코드를 검색
select "15)";

create view hongik_hotel_customers(cid, name, pnumber)
as select stay_information.cid, customer.name, customer.pnumber
   from stay_information, customer
   where stay_information.cid = customer.cid and stay_information.hid in (select hid
																		  from hotel
																		  where name = "홍익호텔");
select * from hongik_hotel_customers;

set foreign_key_checks = 0;    			-- 외래키 체크하지 않는 것으로 설정
drop table IF EXISTS hotel cascade;   				-- 기존 hotel 테이블 제거
drop table IF EXISTS hotelier cascade;   			-- 기존 hotelier 테이블 제거
drop table IF EXISTS hotel_room cascade;   			-- 기존 hotel_room 테이블 제거
drop table IF EXISTS customer cascade;   			-- 기존 customer 테이블 제거
drop table IF EXISTS booking cascade;   			-- 기존 booking 테이블 제거 
drop table IF EXISTS stay_information cascade; 		-- 기존 stay_information 테이블 제거 
drop view IF EXISTS hongik_hotel_customers cascade; -- 기존 hongik_hotel_customers 뷰 제거
set foreign_key_checks = 1;   			-- 외래키 체크하는 것으로 설정mysql> tee output.txt
