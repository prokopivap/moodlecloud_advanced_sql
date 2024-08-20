--CREATE DATABASE bookstore;

CREATE SCHEMA IF NOT EXISTS book;

DROP TABLE IF EXISTS book.Sales;
DROP TABLE IF EXISTS book.Customers;
DROP TABLE IF EXISTS book.Books;
DROP TABLE IF EXISTS book.Authors;
DROP TABLE IF EXISTS book.Genres;

CREATE OR REPLACE PROCEDURE book.create_tables()
LANGUAGE plpgsql
AS $$
BEGIN

	CREATE TABLE IF NOT EXISTS book.Genres (
		 genre_id SERIAL PRIMARY KEY,
		 genre_name VARCHAR(255) NOT NULL
	   );

    CREATE TABLE IF NOT EXISTS book.Authors (
		    author_id SERIAL PRIMARY KEY,
		    name VARCHAR(255) NOT NULL,
		    date_of_birth DATE NOT NULL
        );
    
    CREATE TABLE IF NOT EXISTS book.Books (
		    book_id SERIAL PRIMARY KEY,
		    title VARCHAR(255) NOT NULL,
		    author_id INTEGER NOT NULL,
		    published_date DATE,
		    genre_id INTEGER NOT NULL,
		    price NUMERIC(10, 2) NOT NULL,
		    FOREIGN KEY (author_id) REFERENCES book.Authors(author_id),
		    FOREIGN KEY (genre_id) REFERENCES book.Genres(genre_id)
        );

	CREATE TABLE IF NOT EXISTS book.Customers (
		    customer_id SERIAL PRIMARY KEY,
		    first_name VARCHAR(255) NOT NULL,
		    last_name VARCHAR(255) NOT NULL,
		    email VARCHAR(255) UNIQUE NOT NULL,
		    join_date DATE NOT NULL
         );

    CREATE TABLE IF NOT EXISTS book.Sales (
		    sale_id SERIAL PRIMARY KEY,
		    book_id INTEGER NOT NULL,
		    customer_id INTEGER NOT NULL,
		    quantity INTEGER NOT NULL,
		    sale_date DATE NOT NULL,
		    FOREIGN KEY (book_id) REFERENCES book.Books(book_id),
		    FOREIGN KEY (customer_id) REFERENCES book.Customers(customer_id)
        );

END;
$$;


CREATE OR REPLACE PROCEDURE book.populate_tables_with_data()
LANGUAGE plpgsql
AS $$
BEGIN

	INSERT INTO book.Genres (genre_name) VALUES
		('Fiction'), ('Non-Fiction'), ('Science Fiction'), ('Biography'),
		('Mystery'), ('Romance'), ('Horror'), ('Self Help'),
		('Cooking'), ('Travel'), ('Children'), ('Fantasy'),
		('Historical'), ('Poetry'), ('Educational'), ('Comics'),
		('Art'), ('Music'), ('Science'), ('Philosophy');
		
	INSERT INTO book.Authors (name, date_of_birth) VALUES
		('Jane Austen', '1775-12-16'),
		('Isaac Asimov', '1920-01-02'),
		('George Orwell', '1903-06-25'),
		('J.K. Rowling', '1965-07-31'),
		('Stephen King', '1947-09-21'),
		('Agatha Christie', '1890-09-15'),
		('Mark Twain', '1835-11-30'),
		('Charles Dickens', '1812-02-07'),
		('Virginia Woolf', '1882-01-25'),
		('Ernest Hemingway', '1899-07-21'),
		('William Shakespeare', '1564-04-23'),
		('F. Scott Fitzgerald', '1896-09-24'),
		('Mary Shelley', '1797-08-30'),
		('Harper Lee', '1926-04-28'),
		('Marcel Proust', '1871-07-10'),
		('James Joyce', '1882-02-02'),
		('Franz Kafka', '1883-07-03'),
		('Emily Dickinson', '1830-12-10'),
		('Kurt Vonnegut', '1922-11-11'),
		('Maya Angelou', '1928-04-04');
		
	INSERT INTO book.Books (title, author_id, published_date, genre_id, price) VALUES
		('Pride and Prejudice', 1, '1813-01-28', 1, 19.99),
		('Foundation', 2, '1951-08-21', 3, 22.50),
		('1984', 3, '1949-06-08', 2, 18.00),
		('Harry Potter', 4, '1997-06-26', 12, 24.99),
		('The Garden of Eden', 10, '1985-01-01', 5, 16.00),
		('The Shining', 5, '1977-01-28', 7, 20.00),
		('Murder on the Orient Express', 6, '1934-01-01', 5, 15.00),
		('The Adventures of Tom Sawyer', 7, '1876-01-01', 11, 12.50),
		('Great Expectations', 8, '1861-01-01', 1, 17.50),
		('To the Lighthouse', 9, '1927-05-05', 2, 15.50),
		('The Old Man and the Sea', 10, '1952-09-01', 4, 13.50),
		('Roadwork', 5, '1981-01-01', 7, 21.00),
		('Hamlet', 11, '1603-01-01', 14, 11.00),
		('The Great Gatsby', 12, '1925-04-10', 1, 14.00),
		('Frankenstein', 13, '1818-01-01', 7, 16.50),
		('The Sun Also Rises', 10, '1926-01-01', 7, 21.00),
		('To Kill a Mockingbird', 14, '1960-07-11', 2, 18.00),
		('In Search of Lost Time', 15, '1913-01-01', 13, 21.00),
		('Ulysses', 16, '1922-02-02', 2, 23.00),
		('The Trial', 17, '1925-01-01', 5, 19.00),
		('An Alpine Idyll', 10, '1985-01-01', 6, 20.00),
		('Poems', 18, '1890-01-01', 14, 10.50),
		('Slaughterhouse-Five', 19, '1969-03-31', 3, 21.00),
		('I Know Why the Caged Bird Sings', 20, '1969-01-01', 4, 17.00),
		('Emma', 1, '1815-01-01', 6, 25.00),
		('Persiacion', 1, '1817-01-01', 6, 21.00),
		('Carrie', 5, '1974-01-01', 7, 21.00),
		('Firestarter', 5, '1980-01-01', 7, 19.00),
        ('The Undefeated', 10, '1965-01-01', 5, 17.00),
        ('Sanditon', 1, '1817-01-01', 16, 21.00);
		
		
	INSERT INTO book.Customers (first_name, last_name, email, join_date) VALUES
		('Alice', 'Smith', 'alice.smith@example.com', '2022-01-15'),
		('Bob', 'Jones', 'bob.jones@example.com', '2022-02-20'),
		('Charlie', 'Brown', 'charlie.brown@example.com', '2023-01-01'),
		('Diana', 'Prince', 'diana.prince@example.com', '2023-02-15'),
		('Ethan', 'Hunt', 'ethan.hunt@example.com', '2023-03-25'),
		('Fiona', 'Gallagher', 'fiona.gallagher@example.com', '2022-04-10'),
		('George', 'Bluth', 'george.bluth@example.com', '2023-05-05'),
		('Hannah', 'Abbott', 'hannah.abbott@example.com', '2023-06-15'),
		('Iris', 'West', 'iris.west@example.com', '2023-07-25'),
		('Jack', 'Sparrow', 'jack.sparrow@example.com', '2022-08-30'),
		('Kevin', 'McCallister', 'kevin.mccallister@example.com', '2023-09-10'),
		('Lily', 'Evans', 'lily.evans@example.com', '2022-10-05'),
		('Michael', 'Scott', 'michael.scott@example.com', '2023-11-20'),
		('Nancy', 'Wheeler', 'nancy.wheeler@example.com', '2022-12-15'),
		('Oscar', 'Martinez', 'oscar.martinez@example.com', '2023-01-22'),
		('Phoebe', 'Buffay', 'phoebe.buffay@example.com', '2022-02-28'),
		('Quentin', 'Coldwater', 'quentin.coldwater@example.com', '2023-03-15'),
		('Rachel', 'Green', 'rachel.green@example.com', '2022-04-20'),
		('Steve', 'Harrington', 'steve.harrington@example.com', '2023-05-25'),
		('Tony', 'Stark', 'tony.stark@example.com', '2022-06-30');
		
	INSERT INTO book.Sales (book_id, customer_id, quantity, sale_date) VALUES
		(1, 1, 1, '2023-07-01'),
		(1, 2, 1, '2023-07-01'),
		(2, 2, 1, '2023-07-02'),
		(2, 5, 1, '2023-07-02'),
		(3, 1, 1, '2023-07-03'),
		(3, 3, 1, '2023-07-03'),
		(4, 4, 1, '2023-07-04'),
		(4, 4, 1, '2023-07-05'),
		(5, 7, 1, '2023-07-05'),
		(5, 6, 1, '2023-07-06'),
		(6, 5, 2, '2023-07-06'),
		(6, 8, 1, '2023-07-07'),
		(7, 10, 1, '2023-07-07'),
		(7, 10, 1, '2023-07-08'),
		(8, 12, 1, '2023-07-08'),
		(8, 11, 1, '2023-07-09'),
		(9, 15, 1, '2023-07-09'),
		(9, 16, 1, '2023-07-10'),
		(10, 17, 1, '2023-07-10'),
		(10, 18, 1, '2023-07-11'),
		(1, 1, 1, '2023-07-12'),
		(1, 19, 1, '2023-07-13'),
		(2, 20, 1, '2023-07-13'),
		(2, 18, 1, '2023-07-14'),
		(3, 17, 1, '2023-07-14'),
		(3, 16, 1, '2023-07-15'),
		(4, 15, 1, '2023-07-15'),
		(4, 14, 1, '2023-07-16'),
		(5, 13, 1, '2023-07-16'),
		(5, 12, 1, '2023-07-17'),
		(6, 11, 1, '2023-07-17'),
		(6, 10, 1, '2023-07-18'),
		(7, 9, 1, '2023-07-18'),
		(7, 8, 1, '2023-07-19'),
		(8, 7, 1, '2023-07-19'),
		(8, 6, 1, '2023-07-20'),
		(9, 5, 1, '2023-07-20'),
		(9, 4, 1, '2023-07-21'),
		(10, 3, 1, '2023-07-21'),
		(10, 2, 1, '2023-07-22'),
		(1, 2, 1, '2023-07-22'),
		(1, 3, 1, '2023-07-23'),
		(2, 4, 1, '2023-07-23'),
		(2, 5, 1, '2023-07-24'),
		(3, 6, 1, '2023-07-24'),
		(3, 7, 1, '2023-07-25'),
		(4, 8, 1, '2023-07-25'),
		(4, 9, 1, '2023-07-26'),
		(5, 10, 1, '2023-07-26'),
		(5, 11, 1, '2023-07-27'),
		(6, 12, 1, '2023-07-27');

END;
$$;

CALL book.create_tables();
CALL book.populate_tables_with_data();


--Task 1
-- Create a CTE that calculates the total number of books each author has published. Then, create
-- SELECT query that will use this CTE, and retrieve a list of authors who have published more than 3
-- books, including the number of books they have published.
with cte_books_of_auth_cnt as (
	select 
	  a.name,
	  count(a.author_id) as auth_cnt
	from 
	  book.books b 
	inner join 
	  book.authors a
	on 
	  b.author_id = a.author_id
	where 
	  published_date is not null
	group by 
	  a.name
)
select 
  * 
from 
  cte_books_of_auth_cnt
where 
  auth_cnt > 3;



-- CREATE OR REPLACE function book.authors_count()
--    returns setof authors
--    LANGUAGE plpgsql
-- AS $$
--   with cte_books_of_auth_cnt as (
-- 	select 
-- 	  a.name,
-- 	  count(a.author_id) as auth_cnt
-- 	from 
-- 	  book.books b 
-- 	inner join 
-- 	  book.authors a
-- 	on 
-- 	  b.author_id = a.author_id
-- 	where 
-- 	  published_date is not null
-- 	group by 
-- 	  a.name
-- )
-- select 
--   * 
-- from 
--   cte_books_of_auth_cnt
-- where 
--   auth_cnt > 3;
-- $$;


--Task 2
-- Create a CTE that identifies books whose titles contain the word "The" in any letter case using
-- regular expressions. For example, books with titles like "The Great Gatsby," "The Shining", "The Old
-- Man and the Sea" , or "To the Lighthouse" will meet this criterion. Then, create the SELECT that will
-- this CTE, and retrieve the book titles, corresponding authors, genre, and publication date.
with book_titles_with_the as (
    select
        title,
        author_id,
        genre_id,
        published_date
    from
        book.books
    where
        title ~* '(^|[\s\W])the([\s\W]|$)'
)
select
    title as book_title,
    name as author,
    genre_name,
    published_date
from
    book_titles_with_the main
inner join 
    book.genres as g
on
    g.genre_id = main.genre_id
inner join 
    book.authors a
on a.author_id = main.author_id
;

--Task 3
-- Create a query that ranks books by their price within each genre using the RANK() window
-- function. The goal is to assign a rank to each book based on its price, with the highest-priced book
-- in each genre receiving a rank of 1.
select
    b.title, 
	b.price,
	b.genre_id,
	rank() over (partition by b.genre_id order by price desc) as book_rank
from 
    book.books b
inner join
    book.genres g
on
    g.genre_id = b.genre_id
   
   

--Task 4
-- Create a stored procedure that increases the prices of all books in a specific genre by a specified
-- percentage. The procedure should also output the number of books that were updated. Use RAISE
-- for it.


--select * from book.books where genre_id = 2;


--Try to add genre name in output
CREATE OR REPLACE PROCEDURE book.sp_bulk_update_book_prices_by_genre(
    p_genre_id INT,
    p_percentage_change NUMERIC
)
LANGUAGE plpgsql
AS $$
declare
    books_updated INT;
	--genre_name VARCHAR;
begin
    update book.books
    set price = price + (price * p_percentage_change / 100)
    where genre_id = p_genre_id;

    get diagnostics books_updated = row_count;
	
    raise notice '% books were updated', books_updated;
END;
$$;

CALL book.sp_bulk_update_book_prices_by_genre(2, 10)



--Task 5
-- Create a stored procedure that updates the join_date of each customer to the date of their first
-- purchase if it is earlier than the current join_date. 
-- This ensures that the join_date reflects the true
-- start of the customer relationship.
--select * from book.customers;
--select * from book.sales;

CREATE OR REPLACE PROCEDURE book.sp_update_customer_join_date()
LANGUAGE plpgsql
AS $$
BEGIN
  -- select c.customer_id, c.last_name, c.join_date, s.sale_date
  -- from book.customers c
  -- inner join book.sales s
  -- on c.customer_id = s.customer_id
  -- where s.sale_date < c.join_date
  
  
  update book.customers c
    set join_date = aux.first_sales_date
    from (
        select
            customer_id,
            min(sale_date) as first_sales_date
        from
            book.sales s
        group by
            customer_id
    ) as aux
    where
        c.customer_id = aux.customer_id
        and aux.first_sales_date < c.join_date;

END;
$$;

CALL book.sp_update_customer_join_date()