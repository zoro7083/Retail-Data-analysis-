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

6

