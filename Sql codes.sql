## umions- allows you to combine the table
select roll_no, name, "high" as label 
from college1
where marks >85
union
select roll_no, name, "low" as label
from college1
where marks<85
order by roll_no asc;
select * from college1;




#################string functions#########
select length(name) from college1;
select upper(name) from college1;
select trim("      sky    ");
select left(name, 4), substring(name,2,2) from college1;
select replace(name,'g','G') from college1;
select concat(name," ",city) from college1;




################# case statement############

select name, city,marks,
case
when marks = 85 then 'good'
when marks between 86 and 98 then 'very good'
when marks < 85 then 'not good'
end as remarks
from college1;
select * from college1;

########################### sub query###########
select avg(marks) from college1;

##example one
select name, city, marks
from college1
where marks >(select avg(marks) from college1);

## example two
select name from college1
where roll_no in( select roll_no from college1 where roll_no >102);

######################  window functions################
select 	a.id, a.name,b.name,avg(a.age) over(), ROW_number()over() from college as a
inner join data as b
on a.id = b.id;
select * from college;
select * from data;

#################  cte ########
with cte as
(select col.name,avg(col.age) as average,count(col.id) as count,max(col.age) as max_age
from college as col
join data as dat
on col.id = dat.id
group by name)
select average from
cte;


############ temp table###########
create temporary table data2
select * from college
where age >25;
select * from data2;	


###########stored procedure#########

## example 1
create procedure large_age1()
select * from college
where age>25;

call large_age1();

## example 2
delimiter $$
create procedure new_data1()
begin
select * from college;
select id, name from data;
end $$
delimiter ;

call new_data1();	
select * from college;


############## triggers and events#########
delimiter $$
create trigger college_insert
after insert on data
for each row
begin
insert into college 
values(4,"rahul","nagpur",28);
end $$
delimiter ;
insert into data values(4,"rahul","nagpur",28);
select * from data;



###################  events ############

delimiter $$
create event high_age
on schedule every 30 second
do 
begin
delete from college
where age >27;
end $$
select * from college




