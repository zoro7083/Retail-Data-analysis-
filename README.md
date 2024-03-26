# Retail-Data-analysis-
"Welcome to Retail-Data-analysis, This repository is dedicated to exploring ,extracting and understanding trends,patterns and insights with e-commerce sectors,Using SQL as the primary analytical tool,this repsitory offers a deep drive dive into customer details,sales trends and product performance within the dynamic e-commerce landscape.

# Tools Used : SQL Server,MYSQL workbench

# Datasets:Customers.xlsx,Transactions.xlsx,Prod_cat_info.xlsx

# Customers:
This file contains informmation about customers in the retail dataset it includes attributes such as Customer id,DOB,Gender,City code that helps characterize the customer base.The schema for this dataset is four variable and 5,647 records.

# Transactions:
This file contains information about transactions in the retail dataset it includes attributes such as transaction id,data and time of purchase,customer id,produsct details (such as product category and product sub catrgory) for analyzing sales performance ,identifying popular products,understanding buying patterns and conducting various financial analysis.This schema for this dataset is 10 variable and 23,053 records.

# Prod_cat_info:
This files provides essential infromation about the products available on the e-commerce platform,it includes details such as product category code,product category,product subcategory ,product subcategory .This file helps in analyzing the products,understanding the product details and analyzing the performance of different products schema for this dataset is 4 variables and 23 records.

                                                               # E-Commerce Retail data analysis
#here we have created virtual database db_project so we can  work on our dataset properly and also this will not affect our main dataset. 
#First of all we will understand the data and later we will prepare it properly.
-
First we will see how many records are present in customers,transactions and prod_cat_info
-
---select count(*) from customers; 
---select count(*) from transactions; 
---select count(*) from prod_cat_info;

Here, the records present in customers are 5645,
         records present in transactions are 23053,
          records present in products_cat_info are 23.

Then we see are any of transacions have return
-
---select count(*) from transactions
---where  total_amt <0;




![Screenshot 2024-03-26 185950](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/a52b50b0-06d0-4a63-866a-ed3c1e1ae4d2)


Here, the number of transactions return are 2177.
-
As we have noticed the dates which are provided across the datsets are not in correct format so here we are going the convert the date variables into valid format before proceeding ahead.
-
--alter table transactions
  add  new_date date;

 ---SELECT (DATE_FORMAT(STR_TO_DATE(tran_date, '%d-%m-%Y'), '%Y-%m-%d')) AS new_date from 
    transactions;

---UPDATE  transactions set new_date = (DATE_FORMAT(STR_TO_DATE(tran_date, '%d-%m-%Y'), '%Y-%m- 
   %d')) ;

---select * from transactions;

so we have converted the dates in valid formats
-

Next we will see the time range of the transactions data variable for anlaysis showing the output in number of days,months,and years simultaneously in different columns.
-
---select new_date,curdate() ,month(curdate()),day(new_date),year(new_date)  from transactions;
---select min(new_date)as mini_date ,max(new_date) as maxi_date from transactions;




![Screenshot 2024-03-26 185708](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/b22a370b-18d3-4e1c-b8bb-2924b2f49119)



After that for just example we will see which product category does the sub-category "DIY" belongs to:
-

---select * from prod_cat_info
---where prod_subcat = 'DIY';





![Screenshot 2024-03-26 190405](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/613fc010-43cc-4b13-88b9-249c0fb1512c)

  Data-analysis for  Retail E-commerce datase
  -
1:Business Objective:which channel is mostly freequently used for transactions
-
---select Store_type, count(store_type) as Count_of_stores from Transactions
---group by store_type 
---order by Count_of_stores desc
---limit 1;  




![Screenshot 2024-03-26 192052](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/f22fc91c-f454-4a7b-b4be-355b0cf6a01b)



2:business objective:what is count of male and female customers in the database
-
---select * from customers;
---select gender,count(*) as gender_count  from customers
---group by gender;


![Screenshot 2024-03-26 192244](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/f481fc24-cd68-4393-b56d-d450f4dbef82)

3:business Objective:from which city,we have maximum number of customers and how many
-
---select city_code,count(*) as max_count from customers
---group by city_code 
---limit 1 ;


![Screenshot 2024-03-26 192439](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/388537c1-ddd7-4b7e-aa9d-b0ac7b1ee1db)

4:business objective:how many sub categories are under the books category
-
---select prod_cat,prod_subcat from prod_cat_info
---where prod_cat='Books'
---group by prod_subcat;



![Screenshot 2024-03-26 192945](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/f90091db-b76e-41a4-9374-40738ff0fe08)



5:#Business Objective:what is maximun quantity of products ordered
-
---select max(Qty) from  transactions trans
---inner join prod_cat_info products
---on trans.prod_cat_code=products.prod_cat_code;

---select max(Qty) from transactions;



![Screenshot 2024-03-26 202015](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/3a5fb434-c0f8-47f2-9dad-7536a4822e60)

6:Business Objective:What is the net total revenue generatedd in categories electronics and books
-
---select * from
---prod_cat_info prod
---inner join  transactions trans
---on prod.prod_cat_code=trans.prod_cat_code;

---select prod_cat,sum(total_amt) as amt from prod_cat_info prod
---inner join  transactions trans
---on prod.prod_cat_code=trans.prod_cat_code
---where prod_cat in ('Electronics','Books')
---group by prod_cat;


![Screenshot 2024-03-26 202209](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/403af7f9-25ee-4de7-9a39-88ce2b04089a)

7:Business Objective:-how many customers have >10 transactions with us, excluding returns?
-
---alter table customers
---drop MyUnknownColumn;

---select * from customers cust
---inner join transactions tran
---on cust.customer_id=tran.cust_id;

---select customer_id,count( distinct transaction_id) as total_count from customers cust
---inner join transactions tran
---on cust.customer_id=tran.cust_id 
---group by customer_id 
---having count(distinct transaction_id)>10;


![Screenshot 2024-03-26 202356](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/b957b2ee-91e5-4d1e-9add-423a16d4b141)

8:what is comnbined revenue earned from electronics and clothing categories from
"flagshipstories"
-
---select * from  prod_cat_info;
---select * from transactions;

---select * from prod_cat_info as prod
---join transactions as tran
---on prod.prod_cat_code=tran.prod_cat_code;

---select sum(total_amt) as combined_revenue from prod_cat_info prod
---right join transactions tran
---on prod.prod_cat_code=tran.prod_cat_code
---where store_type='Flagship store'
---and prod_cat in ('Electronics','Clothing');


![Screenshot 2024-03-26 202543](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/44471e08-99b0-4bdd-978c-eb2940c86f8d)


9: Business Objective:-what is total revenue generated from "male customers  in electronics ?ouput should display total revenue by prod sub cat
-
---select * from transactions tran
---join prod_cat_info prod
---on tran.prod_subcat_code=prod.prod_sub_cat_code
---right join customers cust
---on cust.customer_id=tran.cust_id ;

---select gender ,prod_cat,sum(total_amt) as total_revenue from transactions tran
---join prod_cat_info prod
---on tran.prod_subcat_code=prod.prod_sub_cat_code
---right join customers cust
---on cust.customer_id=tran.cust_id
---where gender = 'M'
---group by prod_cat
---having prod_cat like 'Electronics' ;


![Screenshot 2024-03-26 202916](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/98f5ecef-80be-4b00-aef6-98633dcad7d6)

10:#Business Objective: what is percentage of sales and returns by prod sub catgory :display only top 5 sub categories in term of sale
-
---select  (prod_subcat), sum(total_amt) as sales_amount from transactions as tran
---inner join prod_cat_info as prod
---on tran.prod_cat_code=prod.prod_cat_code 
---where tran.total_amt>0
---group by prod_subcat
---order by sales_amount desc
---limit 5;
---with  perABS as(select  prod_subcat,
          ABS(sum(case when total_amt < 0 then total_amt else 0 end)) as returns_v,
                sum(case when total_amt >0 then total_amt else 0 end) as Sales
---from transactions as tran
---inner join prod_cat_info as prod
---on tran.prod_cat_code=prod.prod_cat_code 
---group by prod_subcat
----order by sales desc 
---limit 5 )

---select prod_subcat,round(((returns_v/(returns_v + sales) )*100),2) as Return_percent,
---round(((sales/(returns_v + sales))*100),2) as Sales_percent from perABS;



![Screenshot 2024-03-26 203110](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/85055d83-d3ec-4f80-aa75-c54a4995d3d2)


11::#Business Objective: for all customers aged between 25 to 35 years .find what is net total revenue generated by these comsumers in last 30 days of trnsactions from max transaction table in the data:
-
---alter table customers
---add  new_DOB date;
--- SELECT (DATE_FORMAT(STR_TO_DATE(DOB, '%d-%m-%Y'), '%Y-%m-%d')) AS new_DOB  from -----customers;
---UPDATE  customers set new_DOB= (DATE_FORMAT(STR_TO_DATE(DOB, '%d-%m-%Y'), '%Y-%m-%d')) ;

---alter table customers
drop DOB;
---alter table transactions
drop new_DOB;
select * from customers;
select * from transactions;
---select new_date from transactions
---group by new_date
---order by new_date desc
---limit 30;
---with ABC
---as (select new_date,sum(total_amt) as Total_amount from customers as cust
---inner join transactions as tran
---on tran.cust_id=cust.customer_id
---where timestampdiff(year,new_DOB,curdate()) between 25 and 35
---group by new_date
---order by new_date desc limit 5)
---select sum(Total_amount) as final_revenue from ABC;


![Screenshot 2024-03-26 203435](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/30fcec14-cf64-4050-875c-5978a454d4a3)


12:#Business Objective: which product category has seen the max value of returns in the last 3 months of transaction
-
---select prod_cat,count(Qty) as No_of_returns from transactions tran
---inner join prod_cat_info prod
---on tran.prod_cat_code=prod.prod_cat_code
---where total_amt<0 and timestampdiff(month,'2014-09-01',new_date)=3
---group by prod_cat;

#--product category having maximum value of returns in last three months-----#
---with ABC as
---(select prod_cat,transaction_id,total_amt from transactions tran
---inner join prod_cat_info prod
---on tran.prod_cat_code=prod.prod_cat_code
---where total_amt < 0 and timestampdiff(month,'2014-09-01',new_date)=3)
---select abs(sum(total_amt))as return_amount_cat from ABC;


![Screenshot 2024-03-26 203630](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/4c7234b1-e30d-46af-b09f-30ac64bc8e77)

13:#Business Objective:which store type sells the maximum products:by the value of sales amount and quantity sold
-
select  Store_type ,count(Qty) as no_of_quantity ,sum(total_amt) as total_sales from transactions
 where total_amt > 0 
 group by Store_type
 order by no_of_quantity desc
 limit 1;


 ![Screenshot 2024-03-26 203755](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/4759aa37-3a66-47c0-9983-5539fd441aaa)

 14:business Objective:What are the categories for which average revenue is above the overall average
 -
 ---select prod_cat,round(avg(total_amt)) from transactions tran
 ---inner join prod_cat_info prod
 ---on tran.prod_subcat_code=prod.prod_sub_cat_code
 ---group by prod_cat
 ---having avg(total_amt)>(select avg(total_amt) from transactions);
 
 #----product subcategories having average  revenues greater than the overall average revenue----3
 
 ---select prod.prod_subcat,round(avg(total_amt),2) as averages from transactions tran
 ---inner join prod_cat_info prod
 ---on tran.prod_subcat_code=prod.prod_sub_cat_code
 ---group by prod_subcat
 ---having avg(total_amt)> (select avg(total_amt) from transactions)
 ---order by averages desc ;




 ![Screenshot 2024-03-26 203929](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/066983a8-4e9b-40c0-b09d-768b9d123829)

 15:#business objective:find the average revenue by each subcategory for the categories which are among the top 5 categories in terms of quantity sold
 -
--- select prod_cat,count(Qty) as quantity_sold from transactions tran
---inner join prod_cat_info prod
--- on tran.prod_cat_code=prod.prod_cat_code
---where total_amt>0
--- group by prod_cat
--- order by quantity_sold desc;
 
---  select prod_cat,prod_subcat,round(sum(total_amt),3)as total_amount,round(avg(total_amt),3)as avg_amount from transactions tran
--- inner join prod_cat_info prod
 ---on tran.prod_cat_code=prod.prod_cat_code
--- where total_amt>0 and prod_cat in('Books','Electronics','Home and kitchen','Footwear','Clothing')
--- group by prod_cat,prod_subcat
 ---order by case when prod_cat='Books' then 1
               when prod_cat='Electronics' then 2
               when prod_cat='Home and kitchen' then 3
               when prod_cat='Footwear' then 4
               else 5
               end


![Screenshot 2024-03-26 203929](https://github.com/zoro7083/Retail-Data-analysis-/assets/164145186/a0c213d6-ce89-44a0-858f-43da1c76e85d)

--------------------------------------------------------------------------------------------
