/*ОПЕРАТОРЫ, ФИЛЬТРАЦИЯ, СОРТИРОВКА И ОГРАНИЧАЕНИЯ*/

/* 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.*/
use homework;
update users set created_at = now();
update users set updated_at = now();


/* 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время 
 помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.*/

update users set created_at = STR_TO_DATE(created_at, '%Y-%m-%d %H:%i:%s'), updated_at = STR_TO_DATE(updated_at, '%Y-%m-%d %H:%i:%s');
alter table users modify column created_at datetime, modify column updated_at datetime;


/* 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если 
 товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы 
 они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.*/

select value from storehouses_products order by case when value=0 then 1000000000 else value end;


/* 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
  Месяцы заданы в виде списка английских названий (may, august)*/

select * from users where birthday_at rlike '[0-9]{4}-(05|08)-[0-9]{2}';


/*АГРЕГАЦИЯ ДАННЫХ*/

/* 1. Подсчитайте средний возраст пользователей в таблице users.*/

select avg(TIMESTAMPDIFF(year, birthday_at, now())) from users as average_age;


/* 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

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

/* 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы.*/

select round(exp(sum(log(value)))) as composition from storehouses_products;
