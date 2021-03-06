/*This is a Script that contains the answers of Assignment 2*/
/*
Please fill in the following Information:
*/
Prompt Student ID: 101212631
Prompt Student Name: Lim Jia Lok
Prompt Lab Session: 1


-- Before Adding your answers, make sure that you have:
-- Changed All Tables names in the file (AAB_ASSIGNMENT2_DATA.SQL) by adding the last 4 digits of your ID to each table name
-- 

Prompt -- PART 1 -- -- 

Prompt 1.	Write the SQL statement that will find out if there are any products that have never been ordered
-- add your answer below:

SELECT P.PRODUCTNAME AS "Product Name"
FROM PRODUCTS2631 P
LEFT OUTER JOIN
ORDER_DETAILS2631 D
ON P.PRODUCTID = D.PRODUCTID
WHERE D.PRODUCTID IS NULL;

Prompt 2.	Write the SQL statement that will find out which products have been ordered but never shipped out.
-- add your answer below:

SELECT O.ORDERID AS "Order ID", O.ORDERDATE AS "Order Date", P.PRODUCTNAME AS "Ordered Products"
FROM ORDER_DETAILS2631 D
INNER JOIN 
ORDERS2631 O
ON D.ORDERID = O.ORDERID
INNER JOIN 
PRODUCTS2631 P
ON D.PRODUCTID = P.PRODUCTID
WHERE O.SHIPPEDDATE IS NULL
ORDER BY O.ORDERID;

Prompt 3.	Write the SQL statement that would answer the following question:
--�How many orders have been recorded by each country?�
-- add your answer below:

SELECT SHIPCOUNTRY AS "Country", COUNT(*) AS "Number of Recorded Orders"
FROM ORDERS2631
GROUP BY SHIPCOUNTRY
ORDER BY 2 DESC;

Prompt 4.	Modify your SQL in question 3 so that the result will also display the number of shipped orders as well. The result must be sorted as above.
-- add your answer below:

SELECT SHIPCOUNTRY AS "Country", COUNT(ORDERID) AS "Number of Recorded Orders", COUNT(SHIPPEDDATE) AS "Number of Shipped Orders"
FROM ORDERS2631 O
GROUP BY O.SHIPCOUNTRY
ORDER BY 2 DESC;

Prompt 5.	Modify your answer in question 4 so that the result will show either of the following (for each country):
-- add your answer below:

SELECT O.SHIPCOUNTRY AS "Country", COUNT(O.ORDERID) AS "Number of Recorded Orders", COUNT(O.SHIPPEDDATE) AS "Number of Shipped Orders",
CASE WHEN COUNT(O.ORDERID) = COUNT(O.SHIPPEDDATE) then ' All orders are shipped '
ELSE ' Not all orders are shipped '
END AS "Shipment Status"
FROM ORDERS2631 O
GROUP BY O.SHIPCOUNTRY
ORDER BY 2 DESC;

Prompt 6.	Write a SQL statement that will answer the following question:
--�What is the total sales per product?�
-- add your answer below:

SELECT P.PRODUCTNAME AS "Product Name", SUM(D.QUANTITY * D.UNITPRICE * (1-D.DISCOUNT)) AS "Total Sales"
FROM PRODUCTS2631 P
LEFT OUTER JOIN 
ORDER_DETAILS2631 D
ON P.PRODUCTID = D.PRODUCTID
GROUP BY P.PRODUCTNAME
ORDER BY 2 DESC;

Prompt 7.	Write the necessary SQL statements to display the product category name of the highest total sales (Due to the limitation of 30 words, I had to use Category with Highest Sales.
-- add your answer below:

DROP VIEW PRODUCT_TOTAL_SALES;

CREATE VIEW PRODUCT_TOTAL_SALES AS
SELECT  P.PRODUCTNAME,P.CATEGORYID, SUM(D.QUANTITY * D.UNITPRICE * (1-D.DISCOUNT)) AS "Total Sales"
FROM PRODUCTS2631 P
INNER JOIN
CATEGORIES2631 C
ON P.CATEGORYID = C.CATEGORYID
INNER JOIN 
ORDER_DETAILS2631 D
ON P.PRODUCTID = D.PRODUCTID
GROUP BY P.PRODUCTNAME, P.CATEGORYID
ORDER BY 3 DESC;

SELECT C.CATEGORYNAME AS "Highest Total Sales Category"
FROM CATEGORIES2631 C
INNER JOIN 
PRODUCT_TOTAL_SALES P
ON C.CATEGORYID = P.CATEGORYID
WHERE "Total Sales" = (SELECT MAX("Total Sales") FROM PRODUCT_TOTAL_SALES); 

Prompt 8.	In a single SQL statement, display the following information about customers and suppliers
-- add your answer below:

SELECT S.COMPANYNAME AS "Company Name", S.CITY AS "City", S.COUNTRY AS "Country",CONCAT(CONCAT(S.CONTACTTITLE, ' - '),S.CONTACTNAME) AS "Contact Name", 'Suppliers' AS "User Type"
FROM SUPPLIERS2631 S
UNION
SELECT C.COMPANYNAME AS "Company Name", C.CITY AS "City", C.COUNTRY AS "Country",CONCAT(CONCAT(C.CONTACTTITLE, ' - '),C.CONTACTNAME) AS "Contact Name", 'Customers' AS "User Type"
FROM CUSTOMERS2631 C
ORDER BY 3, 5;

Prompt 9.	In a single SQL statement display employees� names and their manager�s names.
-- add your answer below:

SELECT CONCAT(CONCAT(CONCAT(CONCAT(E.TITLEOFCOURTESY, ' '),E.FIRSTNAME), ' '),E.LASTNAME) AS "Manager Name", CONCAT(CONCAT(CONCAT(CONCAT(F.TITLEOFCOURTESY, ' '),F.FIRSTNAME), ' '),F.LASTNAME) AS "Employee Name"
FROM EMPLOYEES2631 E
INNER JOIN 
EMPLOYEES2631 F
ON E.EMPLOYEEID = F.REPORTSTO
ORDER BY E.TITLEOFCOURTESY;

Prompt 10.	Write the SQL statement that will show invoices for all orders
-- add your answer below:

SELECT O.SHIPNAME AS "Shipname", O.SHIPADDRESS || ', ' || O.SHIPCITY || ', ' || O.SHIPPOSTALCODE || ', ' || O.SHIPCOUNTRY AS "Ship Address", 
O.CUSTOMERID AS "Customer ID", C.CONTACTNAME AS "Customer Name", C.ADDRESS || ', ' || C.CITY || ', ' || C.POSTALCODE || ', ' || C.COUNTRY  AS "Customers' Addresss",
CONCAT(CONCAT(CONCAT(CONCAT(E.TITLEOFCOURTESY, ' '),E.FIRSTNAME), ' '),E.LASTNAME) AS "Employee Name",
O.ORDERID AS "Orders' ID", O.ORDERDATE AS "Order Date", O.REQUIREDDATE AS "Date Required", O.SHIPPEDDATE AS "Shipped Date", S.COMPANYNAME AS "Company Name of Shipper", D.PRODUCTID AS "Product ID",
P.PRODUCTNAME AS "Product Name", D.UNITPRICE AS "Unit Price", D.QUANTITY AS "Quantity of Order", CONCAT(D.DISCOUNT*100, ' %') AS "Discount",
CASE WHEN D.DISCOUNT = 0 THEN D.UNITPRICE * D.QUANTITY
ELSE D.UNITPRICE*D.QUANTITY*(1-D.DISCOUNT)
END AS "Total Price",
O.FREIGHT AS "FREIGHT"
FROM ORDERS2631 O
INNER JOIN
SHIPPERS2631 S
ON O.SHIPVIA = S.SHIPPERID
INNER JOIN
EMPLOYEES2631 E
ON O.EMPLOYEEID = E.EMPLOYEEID
INNER JOIN
CUSTOMERS2631 C
ON O.CUSTOMERID = C.CUSTOMERID
INNER JOIN
ORDER_DETAILS2631 D
ON O.ORDERID = D.ORDERID
INNER JOIN
PRODUCTS2631 P
ON D.PRODUCTID = P.PRODUCTID;

Prompt 11.	Write SQL statements for the following:
--a.	An insert statement that would produce an integrity constraint violation (parent key not found)
-- add your answer below:

INSERT INTO ORDER_DETAILS2631 VALUES (12345, 12, 12,12,0);

--b.	A delete statement that would produce an integrity constraint violation (child record found)
-- add your answer below:

DELETE FROM PRODUCTS2631 WHERE PRODUCTID = 5;

Prompt -- END OF PART I --

Prompt -- PART II --
Prompt 12.	Create all the tables in figure 2 based on the tables in figure 1 without adding the data
--a.	You should drop all the tables first
-- add your answer below:

DROP TABLE DW_CUSTOMERS2631 CASCADE CONSTRAINTS;
DROP TABLE DW_EMPLOYEES2631 CASCADE CONSTRAINTS;
DROP TABLE DW_ORDERS2631 CASCADE CONSTRAINTS;
DROP TABLE DW_PRODUCTS2631 CASCADE CONSTRAINTS;
DROP TABLE DW_DATE2631 cascade constraints;

--b.	Create all the tables using CREATE TABLE�AS SELECT
-- add your answer below:

CREATE TABLE DW_CUSTOMERS2631
AS 
SELECT * FROM CUSTOMERS2631 
WHERE 1 = 0;

CREATE TABLE DW_EMPLOYEES2631
AS
SELECT * FROM EMPLOYEES2631 
WHERE 1 = 0;

CREATE TABLE DW_ORDERS2631
AS 
SELECT * FROM ORDERS2631 
WHERE 1 = 0;

CREATE TABLE DW_PRODUCTS2631
AS 
SELECT * FROM PRODUCTS2631
WHERE 1 = 0;

-----------------------------------------------------------------------------------------------------------------------------
-- TABLE DW_DATE
CREATE TABLE DW_DATE2631 AS
    SELECT 
       TO_DATE('31/12/2014','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day') AS Full_Date,
       TO_CHAR(TO_DATE('31/12/2014','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY') AS YEAR,
       TO_CHAR(TO_DATE('31/12/2014','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Q') AS QUARTER,
       TO_CHAR(TO_DATE('31/12/2014','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Month') AS Month,
       TO_CHAR(TO_DATE('31/12/2014','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'WW') AS Week, 
       TO_CHAR(TO_DATE('31/12/2014','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DD') AS Day      
      
   FROM (
   SELECT LEVEL n
   FROM dual
   CONNECT BY LEVEL <= 2000
   );

----------------------------------------------------------------------------------------------------------------------------
Prompt 13.	Modify the structure of the tables in question 12 to match the design given in figure 2.
--a.	Remove columns
-- add your answer below:
 
 ALTER TABLE DW_CUSTOMERS2631
 DROP (CONTACTNAME, CONTACTTITLE, PHONE, FAX); 
 
 ALTER TABLE DW_EMPLOYEES2631
 DROP (TITLE, TITLEOFCOURTESY, BIRTHDATE, HIREDATE, HOMEPHONE, EXTENSION);
 
 ALTER TABLE DW_ORDERS2631
 DROP (SHIPNAME, SHIPADDRESS, SHIPCITY, SHIPREGION, SHIPPOSTALCODE, SHIPCOUNTRY);


--b.	Add columns
-- add your answer below:

ALTER TABLE DW_ORDERS2631
ADD (
    UnitPrice number(19,4) DEFAULT 0 NOT NULL,
	Quantity number(10) DEFAULT 1 NOT NULL,
	Discount float(23) DEFAULT 0 NOT NULL,
    OID number(10)DEFAULT 0 NOT NULL,
    ProductID number(10) NOT NULL
);

ALTER TABLE DW_PRODUCTS2631
ADD (
    CategoryName varchar2(15) NOT NULL,
    CompanyName varchar2 (40) NOT NULL
);

--c.	Add Primary key constraints
-- add your answer below:

ALTER TABLE DW_CUSTOMERS2631
ADD CONSTRAINT PK_DW_CUSTOMERS2631
PRIMARY KEY (CUSTOMERID);

ALTER TABLE DW_EMPLOYEES2631
ADD CONSTRAINT PK_DW_EMPLOYEES2631
PRIMARY KEY (EMPLOYEEID);

ALTER TABLE DW_ORDERS2631
ADD CONSTRAINT PK_DW_ORDERS2631
PRIMARY KEY (OID);

ALTER TABLE DW_PRODUCTS2631
ADD CONSTRAINT PK_DW_PRODUCTS2631
PRIMARY KEY (PRODUCTID);

ALTER TABLE DW_DATE2631
ADD CONSTRAINT PK_DW_DATE2631
PRIMARY KEY (Full_date);

--d.	Add Foreign key constraints
-- add your answer below:

ALTER TABLE DW_ORDERS2631
ADD CONSTRAINT FK_DW_CUSTOMERS2631_CUSTOMERID
FOREIGN KEY(CUSTOMERID) REFERENCES DW_CUSTOMERS2631(CUSTOMERID);

ALTER TABLE DW_ORDERS2631
ADD CONSTRAINT FK_DW_EMPLOYEES2631_EMPLOYEEID
FOREIGN KEY(EMPLOYEEID) REFERENCES DW_EMPLOYEES2631(EMPLOYEEID);

ALTER TABLE DW_ORDERS2631
ADD CONSTRAINT FK_DW_PRODUCTS2631_PRODUCTID
FOREIGN KEY(PRODUCTID) REFERENCES DW_PRODUCTS2631(PRODUCTID);

ALTER TABLE DW_ORDERS2631
ADD CONSTRAINT FK_DW_DATE2631_ORDERDATE
FOREIGN KEY(ORDERDATE) REFERENCES DW_DATE2631(FULL_DATE);

Prompt 14.	Using INSERT�SELECT, populate the dimension tables from the source tables.
-- add your answer below:

INSERT INTO DW_CUSTOMERS2631(CUSTOMERID, COMPANYNAME, ADDRESS, CITY, REGION, POSTALCODE, COUNTRY)
SELECT C.CUSTOMERID, C.COMPANYNAME, ADDRESS, CITY, REGION, POSTALCODE, COUNTRY
FROM CUSTOMERS2631 C;

INSERT INTO DW_EMPLOYEES2631(EMPLOYEEID, LASTNAME, FIRSTNAME, ADDRESS, CITY, REGION, POSTALCODE, COUNTRY, REPORTSTO)
SELECT E.EMPLOYEEID, E.LASTNAME, E.FIRSTNAME, E.ADDRESS, E.CITY, E.REGION, E.POSTALCODE, E.COUNTRY, E.REPORTSTO
FROM EMPLOYEES2631 E;

INSERT INTO DW_PRODUCTS2631(PRODUCTID, PRODUCTNAME, SUPPLIERID, CATEGORYID, QUANTITYPERUNIT, UNITPRICE, UNITSINSTOCK, UNITSONORDER, REORDERLEVEL, DISCONTINUED, CATEGORYNAME, COMPANYNAME)
SELECT P.PRODUCTID, P.PRODUCTNAME, S.SUPPLIERID, C.CATEGORYID, P.QUANTITYPERUNIT, P.UNITPRICE, P.UNITSINSTOCK, P.UNITSONORDER, P.REORDERLEVEL, P.DISCONTINUED, C.CATEGORYNAME, S.COMPANYNAME
FROM PRODUCTS2631 P
INNER JOIN
CATEGORIES2631 C
ON P.CATEGORYID = C.CATEGORYID
INNER JOIN 
SUPPLIERS2631 S
ON P.SUPPLIERID = S.SUPPLIERID;

Prompt 15.	Using INSERT�SELECT, populate the fact table with the data from the source table(s) 
-- add your answer below:

DROP SEQUENCE SEQUENCE1;

CREATE SEQUENCE SEQUENCE1
START WITH 1 
  INCREMENT BY 1 
  MINVALUE 0 
  NOCACHE 
  NOCYCLE;
                                        
INSERT INTO DW_ORDERS2631(OID, CUSTOMERID, EMPLOYEEID, PRODUCTID, ORDERDATE, ORDERID, REQUIREDDATE, SHIPPEDDATE, SHIPVIA, FREIGHT, UNITPRICE, QUANTITY, DISCOUNT)
SELECT SEQUENCE1.NEXTVAL, O.CUSTOMERID, O.EMPLOYEEID, D.PRODUCTID, O.ORDERDATE, O.ORDERID, O.REQUIREDDATE, O.SHIPPEDDATE, O.SHIPVIA, O.FREIGHT, D.UNITPRICE, D.QUANTITY, D.DISCOUNT
FROM ORDERS2631 O
INNER JOIN 
ORDER_DETAILS2631 D
ON O.ORDERID = D.ORDERID
WHERE O.SHIPPEDDATE IS NOT NULL;

Prompt 16.	Write the SQL statement that would Find the total revenues in the first quarter of the years 2015 and 2016 
-- add your answer below:

SELECT D.YEAR AS "First Quarter of Year", SUM(O.QUANTITY * O.UNITPRICE * (1 - O.DISCOUNT)) AS "Total Revenues"
FROM DW_DATE2631 D
LEFT OUTER JOIN 
DW_ORDERS2631 O
ON D.FULL_DATE = O.ORDERDATE
WHERE D.QUARTER = 1 AND (D.YEAR = 2015 OR D.YEAR = 2016)
GROUP BY D.YEAR
ORDER BY 2 DESC;

Prompt 17.	Write the SQL statement that would find the total purchases made by country and customers within each country. 
-- add your answer below:

SELECT C.COMPANYNAME AS "Company Name", C.COUNTRY AS "Country", ROUND(SUM(O.QUANTITY * O.UNITPRICE * (1 - O.DISCOUNT)), 0) AS "Total Purchase"
FROM DW_CUSTOMERS2631 C
INNER JOIN
DW_ORDERS2631 O
ON C.CUSTOMERID = O.CUSTOMERID
GROUP BY C.COMPANYNAME, C.COUNTRY
ORDER BY 2, 3 DESC;

Prompt 18.	Modify your answer in question 17 so that the result will show total purchases by quarter in the year 2017
-- add your answer below:

SELECT C.COMPANYNAME AS "Company Name", C.COUNTRY AS "Country", ROUND(SUM(O.QUANTITY * O.UNITPRICE * (1 - O.DISCOUNT)), 0) AS "Total Purchase", D.QUARTER AS "Quarter"
FROM DW_ORDERS2631 O 
INNER JOIN
DW_CUSTOMERS2631 C
ON O.CUSTOMERID = C.CUSTOMERID
INNER JOIN DW_DATE2631 D
ON O.ORDERDATE = D.FULL_DATE
WHERE D.YEAR = 2017
GROUP BY C.COMPANYNAME, C.COUNTRY, D.QUARTER
HAVING ROUND(SUM(O.QUANTITY * O.UNITPRICE * (1-O.DISCOUNT)), 0) > 10000
ORDER BY 4, 3 DESC;

Prompt 19.	Write the SQL statement that would show the rank of products by their total sales
-- add your answer below:

SELECT P.PRODUCTNAME AS "Product Name", ROUND(SUM(O.QUANTITY * O.UNITPRICE * (1 - O.DISCOUNT)), 0) AS "Total Sales", 
RANK () OVER (
    ORDER BY ROUND(SUM(O.QUANTITY * O.UNITPRICE * (1-O.DISCOUNT)), 0) DESC
    ) AS "Ranking by Sales"
FROM DW_PRODUCTS2631 P
INNER JOIN 
DW_ORDERS2631 O
ON P.PRODUCTID = O.PRODUCTID
GROUP BY P.PRODUCTNAME;


Prompt 20.	Write two SQL statements to show A rollup operation
-- add your answer below:

SELECT P.PRODUCTNAME AS "Product Name", P.CATEGORYNAME AS "Category", P.COMPANYNAME AS "Supplier Company", ROUND(SUM(O.QUANTITY * O.UNITPRICE * (1 - O.DISCOUNT)), 0) AS "Total Sales"
FROM DW_PRODUCTS2631 P
INNER JOIN 
DW_ORDERS2631 O
ON P.PRODUCTID = O.PRODUCTID
GROUP BY CUBE(P.PRODUCTNAME, P.CATEGORYNAME, P.COMPANYNAME);

Prompt 20.	Write two SQL statements to show A cube operation
-- add your answer below:

SELECT C.COMPANYNAME AS "Company Name", C.CITY AS "City", C.COUNTRY AS "Country", ROUND(SUM(O.QUANTITY * O.UNITPRICE * (1 - O.DISCOUNT)), 0) AS "Total Purchase"
FROM DW_CUSTOMERS2631 C
INNER JOIN
DW_ORDERS2631 O
ON C.CUSTOMERID = O.CUSTOMERID
GROUP BY CUBE (C.COMPANYNAME, C.CITY, C.COUNTRY);