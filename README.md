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


After that for just example we will see which product category does the sub-category "DIY" belongs to:
-

---
