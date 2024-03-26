use db_project;
select * from customers;
select * from transactions;
select * from prod_cat_info;

alter table customers
rename column ï»¿customer_Id to customer_id;

select * from customers;

alter table transactions
rename column ï»¿transaction_id to transaction_id;

select * from transactions;

#-------#UNDERSTANDING AND DATA PREPARATION#---------#

#-------#total number of rows in each of the 3 tables in the database#---------#
select count(*) from customers; 
select count(*) from transactions; 
select count(*) from prod_cat_info;


#-------# What is the number of transactions that have a return#-----#
select count(*) from transactions
where  total_amt <0;

#-----#converting date into valid format#------------3
alter table transactions
 add  new_date date;

 SELECT (DATE_FORMAT(STR_TO_DATE(tran_date, '%d-%m-%Y'), '%Y-%m-%d')) AS new_date from transactions;

UPDATE  transactions set new_date = (DATE_FORMAT(STR_TO_DATE(tran_date, '%d-%m-%Y'), '%Y-%m-%d')) ;

select * from transactions;

 alter table transactions
 drop tran_date;
 
 select * from transactions;
 
 #-------#time range of transaction data available for analysis,showing output in number of days,months,days in different columns.#---------#
select new_date,curdate() ,month(curdate()),day(new_date),year(new_date)  from transactions;
select min(new_date)as mini_date ,max(new_date) as maxi_date from transactions;

#--------#which product category does the sub category "DIY' belong to?#--------4
select * from prod_cat_info
where prod_subcat = 'DIY';


#business objectives

#-----------1:#Business Objective:which channel is mostly freequently used for transactions#-------#
select Store_type, count(store_type) as Count_of_stores from Transactions
group by store_type 
order by Count_of_stores desc
limit 1;


#----------2:#business objective:what is count of male and female customers in the database#--------#
select * from customers;
select gender,count(*) as gender_count  from customers
group by gender;


#---------3:#business Objective:from which city,we have maximum number of customers and how many#-----------#
select city_code,count(*) as max_count from customers
group by city_code 
limit 1 ;

#--------4:#business objective:how many sub categories are under the books category#---------#
select prod_cat,prod_subcat from prod_cat_info
where prod_cat='Books'
group by prod_subcat;

#--------5:#Business Objective:what is maximun quantity of products ordered#-----------------#
select max(Qty) from  transactions trans
inner join prod_cat_info products
on trans.prod_cat_code=products.prod_cat_code;

select max(Qty) from transactions;

#------------6:#Business Objective:What is the net total revenue generatedd in categories electronics and books#---------------#
select * from transactions;
select * from prod_cat_info;

select * from
 prod_cat_info prod
inner join  transactions trans
on prod.prod_cat_code=trans.prod_cat_code;

select prod_cat,sum(total_amt) as amt from prod_cat_info prod
inner join  transactions trans
on prod.prod_cat_code=trans.prod_cat_code
where prod_cat in ('Electronics','Books')
group by prod_cat;


#-----------7:#Business Objective:-how many customers have >10 transactions with us, excluding returns?#-----------#
select * from transactions;
select * from customers;
alter table customers
drop MyUnknownColumn;

select * from customers cust
inner join transactions tran
on cust.customer_id=tran.cust_id;

select customer_id,count( distinct transaction_id) as total_count from customers cust
inner join transactions tran
on cust.customer_id=tran.cust_id 
group by customer_id 
having count(distinct transaction_id)>10;


#---------8:#what is comnbined revenue earned from electronics and clothing categories from "flagship stories"#_---------------------#
select * from  prod_cat_info;
select * from transactions;

select * from prod_cat_info as prod
join transactions as tran
on prod.prod_cat_code=tran.prod_cat_code;

select sum(total_amt) as combined_revenue from prod_cat_info prod
right join transactions tran
on prod.prod_cat_code=tran.prod_cat_code
where store_type='Flagship store'
and prod_cat in ('Electronics','Clothing');

#----------9:# Business Objective:-what is total revenue generated from "male customers  in electronics ?ouput should display total revenue by prod sub cat#-----------------#\
select * from transactions tran
join prod_cat_info prod
on tran.prod_subcat_code=prod.prod_sub_cat_code
right join customers cust
on cust.customer_id=tran.cust_id ;

select gender ,prod_cat,sum(total_amt) as total_revenue from transactions tran
join prod_cat_info prod
on tran.prod_subcat_code=prod.prod_sub_cat_code
right join customers cust
on cust.customer_id=tran.cust_id
where gender = 'M'
group by prod_cat
having prod_cat like 'Electronics' ;


#-----------10:#Business Objective: what is percentage of sales and returns by prod sub catgory :display only top 5 sub categories in term of sale#---------#
select  (prod_subcat), sum(total_amt) as sales_amount from transactions as tran
inner join prod_cat_info as prod
on tran.prod_cat_code=prod.prod_cat_code 
where tran.total_amt>0
group by prod_subcat
order by sales_amount desc
limit 5;
with  perABS as(select  prod_subcat,
                ABS(sum(case when total_amt < 0 then total_amt else 0 end)) as returns_v,
                sum(case when total_amt >0 then total_amt else 0 end) as Sales
from transactions as tran
inner join prod_cat_info as prod
on tran.prod_cat_code=prod.prod_cat_code 
group by prod_subcat
order by sales desc 
limit 5 )

select prod_subcat,round(((returns_v/(returns_v + sales) )*100),2) as Return_percent,
round(((sales/(returns_v + sales))*100),2) as Sales_percent from perABS;

#------------11:#Business Objective: for all customers aged between 25 to 35 years .find what is net total revenue generated by these comsumers in last 30 days of trnsactions from max transaction table in the data:#--------#
alter table customers
 add  new_DOB date;
 SELECT (DATE_FORMAT(STR_TO_DATE(DOB, '%d-%m-%Y'), '%Y-%m-%d')) AS new_DOB  from customers;
UPDATE  customers set new_DOB= (DATE_FORMAT(STR_TO_DATE(DOB, '%d-%m-%Y'), '%Y-%m-%d')) ;

alter table customers
drop DOB;
alter table transactions
drop new_DOB;
select * from customers;
select * from transactions;
select new_date from transactions
group by new_date
order by new_date desc
limit 30;
with ABC
as (select new_date,sum(total_amt) as Total_amount from customers as cust
inner join transactions as tran
on tran.cust_id=cust.customer_id
where timestampdiff(year,new_DOB,curdate()) between 25 and 35
group by new_date
order by new_date desc limit 5)
select sum(Total_amount) as final_revenue from ABC;


#----------12:#Business Objective: which product category has seen the max value of returns in the last 3 months of transactions#------#
select prod_cat,count(Qty) as No_of_returns from transactions tran
inner join prod_cat_info prod
on tran.prod_cat_code=prod.prod_cat_code
where total_amt<0 and timestampdiff(month,'2014-09-01',new_date)=3
group by prod_cat;

#--product category having maximum value of returns in last three months-----#
with ABC as
(select prod_cat,transaction_id,total_amt from transactions tran
inner join prod_cat_info prod
on tran.prod_cat_code=prod.prod_cat_code
where total_amt < 0 and timestampdiff(month,'2014-09-01',new_date)=3)
select abs(sum(total_amt))as return_amount_cat from ABC;


#--------13:#Business Objective:which store type sells the maximum products:by the value of sales amount and quantity sold#-------#
select  Store_type ,count(Qty) as no_of_quantity ,sum(total_amt) as total_sales from transactions
 where total_amt > 0 
 group by Store_type
 order by no_of_quantity desc
 limit 1;
 
 #-------14:#business Objective:What are the categories for which average revenue is above the overall average#------#
 select prod_cat,round(avg(total_amt)) from transactions tran
 inner join prod_cat_info prod
 on tran.prod_subcat_code=prod.prod_sub_cat_code
 group by prod_cat
 having avg(total_amt)>(select avg(total_amt) from transactions);
 
 #----product subcategories having average  revenues greater than the overall average revenue----3
 select prod.prod_subcat,round(avg(total_amt),2) as averages from transactions tran
 inner join prod_cat_info prod
 on tran.prod_subcat_code=prod.prod_sub_cat_code
 group by prod_subcat
 having avg(total_amt)> (select avg(total_amt) from transactions)
 order by averages desc ;
 
 
 #------------15:#business objective:find the average revenue by each subcategory for the categories which are among the top 5 categories in terms of quantity sold#---------#
 select prod_cat,count(Qty) as quantity_sold from transactions tran
 inner join prod_cat_info prod
 on tran.prod_cat_code=prod.prod_cat_code
 where total_amt>0
 group by prod_cat
 order by quantity_sold desc;
 
  select prod_cat,prod_subcat,round(sum(total_amt),3)as total_amount,round(avg(total_amt),3)as avg_amount from transactions tran
 inner join prod_cat_info prod
 on tran.prod_cat_code=prod.prod_cat_code
 where total_amt>0 and prod_cat in('Books','Electronics','Home and kitchen','Footwear','Clothing')
 group by prod_cat,prod_subcat
 order by case when prod_cat='Books' then 1
               when prod_cat='Electronics' then 2
               when prod_cat='Home and kitchen' then 3
               when prod_cat='Footwear' then 4
               else 5
               end