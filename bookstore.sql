
CREATE DATABASE book_store;
USE book_store;

-- Create Authors table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100)
);
-- Create Publications 
CREATE TABLE Publications (
    publication_id INT PRIMARY KEY,
    publication_name VARCHAR(255),
    publication_type VARCHAR(50)
);

-- Create Books table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(255),
    author_id INT,
    publication_id INT,
    price DECIMAL(10, 2),
    published_date DATE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (publication_id) REFERENCES Publications(publication_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    date_of_birth DATE,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  total_amount DECIMAL(10, 2),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create OrderDetails table
CREATE TABLE OrderDetails (
  order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  book_id INT NOT NULL,
  quantity INT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  discount DECIMAL(10, 2) DEFAULT 0, -- Optional: Discount applied
  tax DECIMAL(10, 2) DEFAULT 0, -- Optional: Tax applied
  shipping_cost DECIMAL(10, 2) DEFAULT 0, -- Optional: Shipping cost
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (book_id) REFERENCES Books(book_id),
  UNIQUE KEY (order_id, book_id)
);

-- Insert sample data into Authors table
INSERT INTO Authors (author_id, author_name) VALUES
(1, 'J.K. Rowling'),
(2, 'Stephen King'),
(3, 'Harper Lee');

-- Insert sample data into Publications table
INSERT INTO Publications (publication_id, publication_name, publication_type) VALUES
(1, 'New York Times', 'Newspaper'),
(2, 'Time Magazine', 'Magazine');

-- Insert sample data into Books table
INSERT INTO Books (book_id, book_title, author_id, publication_id, price, published_date) VALUES
(1, 'Harry Potter and the Philosopher''s Stone', 1, 2, 599.00, '1945-06-26'),
(2, 'The Shining', 2, 1, 300, '1997-01-28'),
(3, 'To Kill a Mockingbird', 3, 1, 200.00, '2000-07-11');


-- Insert sample data into Customers table
INSERT INTO Customers (customer_id, customer_name, email, phone, address, city, state, country, postal_code, date_of_birth) VALUES
(1, 'John Doe', 'john@example.com', '123-456-7890', '123 Main St', 'Anytown', 'State', 'Country', '12345', '1990-01-01'),
(2, 'Jane Smith', 'jane@example.com', '987-654-3210', '456 Elm St', 'Othertown', 'State', 'Country', '54321', '1995-05-15'),
(3, 'Alice Johnson', 'alice@example.com', '555-123-4567', '789 Oak St', 'Anothertown', 'State', 'Country', '67890', '1985-12-10'),
(4, 'Bob Williams', 'bob@example.com', '333-444-5555', '321 Pine St', 'Somewhere', 'State', 'Country', '98765', '1978-08-20'),
(5, 'Emily Brown', 'emily@example.com', '111-222-3333', '654 Birch St', 'Nowhere', 'State', 'Country', '23456', '2000-03-25');

INSERT INTO Orders (customer_id, order_date, total_amount)
VALUES
(1, '2024-02-12', 320.00),
(2, '2024-02-10', 480.00),
(3, '2024-02-11', 200.00),
(4, '2024-02-09', 180.00),
(5, '2024-02-08', 599.00);

INSERT INTO OrderDetails (order_id, book_id, quantity, price)
VALUES
(1, 1, 1, 599.00),
(2, 2, 1, 300.00),
(2, 3, 2, 150.00),
(3, 3, 1, 120.00),
(3, 1, 1, 200.00),
(4, 2, 1, 250.00),
(5, 1, 1, 200.00),
(5, 3, 1, 100.00);

-- Retrieve a list of top-selling books
SELECT Books.book_id, Books.book_title, Authors.author_name, COUNT(OrderDetails.book_id) AS total_sold
FROM Books
JOIN Authors ON Books.author_id = Authors.author_id
JOIN OrderDetails ON Books.book_id = OrderDetails.book_id
GROUP BY Books.book_id, Books.book_title, Authors.author_name
ORDER BY total_sold DESC;

-- Calculate total sales revenue for a given period
SELECT SUM(OrderDetails.quantity * OrderDetails.price) AS total_revenue
FROM Orders
JOIN OrderDetails ON Orders.order_id = OrderDetails.order_id
WHERE Orders.order_date BETWEEN '2024-01-01' AND '2024-3-31';