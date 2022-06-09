create database testdb_C;
use testdb_C;

create table users (
uno int primary key,
uid varchar(20),
upw varchar(20),
police varchar(50),
uname varchar(40)
);

insert into users values('32001', 'kwon', '1234', '인천지방경찰청', '권두하');

select * from users;

create table android(
a_uid int primary key auto_increment,
a_uname varchar(40),
deviceid varchar(40),
car_num varchar(40)
);

insert into android(deviceid) values('b817725805931ea0');

update android set car_num = '12가3456', a_uname = '홍길동' where a_uid = 1;

select * from android;

create table report(
rno int primary key auto_increment,
r_lat varchar(100),
r_lng varchar(100),
rme varchar(200),
rdate datetime default now(),
raddr varchar(300),
rcheck boolean default false,
a_uid int,
foreign key (a_uid) references android(a_uid)
);

select * from report;

select * from report, android where report.a_uid = android.a_uid and rno = 1;

insert into report(r_lat, r_lng, rme, a_uid) values('37.502985', '126.714726', '259', 1);
insert into report(r_lat, r_lng, rme, a_uid) values('37.448220', '126.657504', '312', 1);
insert into report(r_lat, r_lng, rme, a_uid) values('37.444685', '126.662214', '261', 1);
insert into report(r_lat, r_lng, rme, a_uid) values('37.497371', '126.724055', '403', 1);

select * from report, android where report.a_uid = android.a_uid and rcheck = false order by rdate;

update report set rcheck = false where rno = 4;


create table board (
bno int primary key auto_increment,
rno int,
uno int,
cp varchar(40),
bcontent longtext,
bdate datetime default now(),
btitle varchar(100),
foreign key (rno) references report(rno),
foreign key (uno) references users(uno));

select * from board;
select * from board, report where bno = 1 and board.rno = report.rno;