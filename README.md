# Book Store Database

## Overview
This repository contains SQL scripts to create a database schema for a book store, along with sample data and queries to retrieve useful information from the database.

## Database Schema
The database schema consists of the following tables:

- **Authors**: Contains information about book authors.
- **Publications**: Stores details about publications such as newspapers and magazines.
- **Books**: Holds information about books including title, author, publication, price, and published date.
- **Customers**: Stores customer information like name, email, address, etc.
- **Orders**: Contains details of customer orders including order date and total amount.
- **OrderDetails**: Stores details of each item in an order including quantity, price, and any applied discounts or taxes.

## Sample Data
The SQL scripts also include sample data inserts for the following tables:
- Authors
- Publications
- Books
- Customers
- Orders
- OrderDetails

This sample data is provided to demonstrate the functionality of the database schema.

## Queries
The repository includes sample SQL queries to perform the following tasks:

### Retrieve a list of top-selling books
This query retrieves a list of the top-selling books along with the total number of copies sold.

```sql
SELECT Books.book_id, Books.book_title, Authors.author_name, COUNT(OrderDetails.book_id) AS total_sold
FROM Books
JOIN Authors ON Books.author_id = Authors.author_id
JOIN OrderDetails ON Books.book_id = OrderDetails.book_id
GROUP BY Books.book_id, Books.book_title, Authors.author_name
ORDER BY total_sold DESC;
```
![Book Store](https://github.com/KartikDevarde2601/book_store/blob/main/result%202.png "Result")


### Calculate total sales revenue for a given period
This query calculates the total sales revenue for a specified period.

```sql
SELECT SUM(OrderDetails.quantity * OrderDetails.price) AS total_revenue
FROM Orders
JOIN OrderDetails ON Orders.order_id = OrderDetails.order_id
WHERE Orders.order_date BETWEEN '2024-01-01' AND '2024-03-31';
```
![Book Store](https://github.com/KartikDevarde2601/book_store/blob/main/result%202.png "Result")
## Usage
To use the provided SQL scripts and queries, follow these steps:
1. Execute the SQL scripts to create the database schema and insert sample data.
2. Execute the sample queries to retrieve information from the database.

Feel free to customize or expand upon these scripts and queries to suit your specific requirements.


 
