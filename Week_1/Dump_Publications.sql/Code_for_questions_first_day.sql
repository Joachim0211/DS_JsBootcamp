USE	Publications;
SELECT * FROM authors;
SELECT au_fname, au_lname FROM authors;
SELECT CONCAT(au_fname, ' ', au_lname) AS fullname FROM authors;
SELECT DISTINCT au_fname FROM authors;
SELECT au_fname, au_lname FROM authors WHERE au_lname = 'Ringer';
SELECT au_fname, au_lname, city FROM authors WHERE au_fname = 'Dean' AND city = ('Oakland' OR city = 'Berkeley');
SELECT au_fname, au_lname, city FROM authors WHERE au_lname != 'Straight' AND (city = 'Oakland' OR city='Berkeley');
SELECT title, ytd_sales From titles ORDER BY ytd_sales DESC;
SELECT title, ytd_sales From titles ORDER BY ytd_sales DESC LIMIT 5;
SELECT MAX(qty) AS max, MIN(qty) AS min FROM sales;
SELECT COUNT(qty) AS count, AVG(qty) AS avg_qty, SUM(qty) AS sum_qty FROM sales;
SELECT title FROM titles WHERE title LIKE '%cooking%';
SELECT title FROM titles WHERE title LIKE '%____ing%';
SELECT * FROM authors WHERE city NOT IN ('Salt Lake City', 'Ann Arbor','Oakland');
SELECT * FROM sales WHERE qty BETWEEN 25 AND 45;
SELECT * FROM sales WHERE ord_date BETWEEN '1993-03-11' AND '1994-09-13';
SELECT * FROM sales WHERE ord_date BETWEEN '1993-03-11' AND '1994-09-13' ORDER BY qty LIMIT 5;
SELECT COUNT(*) FROM authors WHERE au_fname LIKE "%i%" AND state IN ("CA","MD","KS");
SELECT SUM(ytd_sales) FROM titles WHERE price BETWEEN 15 AND 25 ORDER BY royalty ASC LIMIT 5;
SELECT state, COUNT(*) FROM authors GROUP BY state;
SELECT state, COUNT(*) FROM authors GROUP BY state ORDER BY COUNT(*) DESC;
SELECT pub_id, MAX(price) FROM titles GROUP BY pub_id;



 



