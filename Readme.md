# 🛒 E-Commerce Database Schema (SQL Server)

## 📌 Overview
This project contains a **normalized relational database schema** for an **E-commerce system**, designed in **SQL Server (T-SQL)**.  
It models customers, products, orders, payments, shipping, reviews, and admin users with proper **Primary Keys, Foreign Keys, and relationships**.

The schema is normalized up to **3NF** and follows best practices for database design.

---

## 📂 Schema Features
✅ Normalized (1NF → 3NF)  
✅ Primary Keys & Foreign Keys  
✅ CHECK constraints for data validation  
✅ Many-to-Many handled via bridge table (`OrderItems`)  
✅ Surrogate keys using `IDENTITY(1,1)`  
✅ Designed for SQL Server (T-SQL)  

---

## 📊 ER Diagram
![ER Diagram](./er_diagram.png)

### Relationships:
- **Customers → Orders** (1:M)  
- **Orders → OrderItems** (1:M)  
- **Products → OrderItems** (1:M)  
- **Categories → Products** (1:M)  
- **Orders → Payments** (1:M)  
- **Orders → Shipping** (1:1)  
- **Products → Reviews** (1:M)  
- **Customers → Reviews** (1:M)  

---

## ⚙️ Setup Instructions
1. Open **SQL Server Management Studio (SSMS)**.
2. Run the script from [`schema.sql`](./schema.sql).
3. The database `EcommerceDB` will be created with all tables.

```sql
-- Create Database
CREATE DATABASE EcommerceDB;
GO
USE EcommerceDB;
GO

-- Run the rest of schema.sql file
