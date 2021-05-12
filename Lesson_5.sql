/*���������, ����������, ���������� � ������������*/

/* 1. ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.*/
use homework;
update users set created_at = now();
update users set updated_at = now();


/* 2. ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� 
 ���������� �������� � ������� 20.10.2017 8:10. ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.*/

update users set created_at = STR_TO_DATE(created_at, '%Y-%m-%d %H:%i:%s'), updated_at = STR_TO_DATE(updated_at, '%Y-%m-%d %H:%i:%s');
alter table users modify column created_at datetime, modify column updated_at datetime;


/* 3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� 
 ����� ���������� � ���� ����, ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, ����� 
 ��� ���������� � ������� ���������� �������� value. ������ ������� ������ ������ ���������� � �����, ����� ���� �������.*/

select value from storehouses_products order by case when value=0 then 1000000000 else value end;


/* 4. (�� �������) �� ������� users ���������� ������� �������������, ���������� � ������� � ���. 
  ������ ������ � ���� ������ ���������� �������� (may, august)*/

select * from users where birthday_at rlike '[0-9]{4}-(05|08)-[0-9]{2}';


/*��������� ������*/

/* 1. ����������� ������� ������� ������������� � ������� users.*/

select avg(TIMESTAMPDIFF(year, birthday_at, now())) from users as average_age;


/* 2. ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������.
 * ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.*/

create table birhtday (birthday_at date);
insert into	 birhtday(birthday_at) values
('2021-10-05'),
('2021-11-12'),
('2021-05-20'),
('2021-02-14'),
('2021-01-12'),
('2021-08-29');
select dayname(birthday_at) as day_of_week from birhtday;
select count(*) as sum_of_days, substring(dayname(birthday_at), 1, 10) as days from birhtday group by days;

/* 3. (�� �������) ����������� ������������ ����� � ������� �������.*/

select round(exp(sum(log(value)))) as composition from storehouses_products;
