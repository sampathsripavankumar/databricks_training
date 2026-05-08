1. SELECT employee_id, employee_name, salary,
           ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
    FROM employees;

| employee_id | employee_name | salary  | row_num |
| ----------- | ------------- | ------- | ------- |
| 4           | Diana Prince  | 95000.0 | 1       |
| 3           | Charlie Brown | 90000.0 | 2       |
| 7           | George Miller | 85000.0 | 3       |
| 8           | Hannah Lee    | 82000.0 | 4       |
| 1           | Alice Johnson | 70000.0 | 5       |
| 2           | Bob Smith     | 65000.0 | 6       |
| 5           | Ethan Hunt    | 60000.0 | 7       |
| 6           | Fiona Green   | 58000.0 | 8       |

2.  SELECT employee_id, employee_name, salary,
           RANK() OVER (ORDER BY salary DESC) AS salary_rank
    FROM employees;

| employee_id | employee_name | salary  | salary_rank |
| ----------- | ------------- | ------- | ----------- |
| 4           | Diana Prince  | 95000.0 | 1           |
| 3           | Charlie Brown | 90000.0 | 2           |
| 7           | George Miller | 85000.0 | 3           |
| 8           | Hannah Lee    | 82000.0 | 4           |
| 1           | Alice Johnson | 70000.0 | 5           |
| 2           | Bob Smith     | 65000.0 | 6           |
| 5           | Ethan Hunt    | 60000.0 | 7           |
| 6           | Fiona Green   | 58000.0 | 8           |

3.


4.  SELECT *
    FROM (
        SELECT employee_id, employee_name, salary,
               ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
        FROM employees
    ) t
    WHERE rn <= 3;

| employee_id | employee_name | salary  | rn  |
| ----------- | ------------- | ------- | --- |
| 4           | Diana Prince  | 95000.0 | 1   |
| 3           | Charlie Brown | 90000.0 | 2   |
| 7           | George Miller | 85000.0 | 3   |

5.  SELECT employee_id, employee_name, department, salary,
           RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank
    FROM employees;

| employee_id | employee_name | department | salary  | dept_rank |
| ----------- | ------------- | ---------- | ------- | --------- |
| 7           | George Miller | Finance    | 85000.0 | 1         |
| 8           | Hannah Lee    | Finance    | 82000.0 | 2         |
| 5           | Ethan Hunt    | HR         | 60000.0 | 1         |
| 6           | Fiona Green   | HR         | 58000.0 | 2         |
| 4           | Diana Prince  | IT         | 95000.0 | 1         |
| 3           | Charlie Brown | IT         | 90000.0 | 2         |
| 1           | Alice Johnson | Sales      | 70000.0 | 1         |
| 2           | Bob Smith     | Sales      | 65000.0 | 2         |

6. SELECT employee_id, employee_name, department, salary,
           MAX(salary) OVER (PARTITION BY department) AS highest_salary
    FROM employees;

| employee_id | employee_name | department | salary  | highest_salary |
| ----------- | ------------- | ---------- | ------- | -------------- |
| 7           | George Miller | Finance    | 85000.0 | 85000.0        |
| 8           | Hannah Lee    | Finance    | 82000.0 | 85000.0        |
| 5           | Ethan Hunt    | HR         | 60000.0 | 60000.0        |
| 6           | Fiona Green   | HR         | 58000.0 | 60000.0        |
| 3           | Charlie Brown | IT         | 90000.0 | 95000.0        |
| 4           | Diana Prince  | IT         | 95000.0 | 95000.0        |
| 1           | Alice Johnson | Sales      | 70000.0 | 70000.0        |
| 2           | Bob Smith     | Sales      | 65000.0 | 70000.0        |

7. SELECT order_id, order_date, total_amount,
           SUM(total_amount) OVER (ORDER BY order_date) AS running_total
    FROM orders;

| order_id | order_date | total_amount | running_total |
| -------- | ---------- | ------------ | ------------- |
| 101      | 2024-01-10 | 500.0        | 500.0         |
| 102      | 2024-01-11 | 700.0        | 1200.0        |
| 103      | 2024-01-15 | 1200.0       | 2400.0        |
| 104      | 2024-01-18 | 300.0        | 2700.0        |
| 105      | 2024-01-20 | 900.0        | 3600.0        |
| 106      | 2024-01-25 | 1500.0       | 5100.0        |
| 107      | 2024-02-01 | 650.0        | 5750.0        |
| 108      | 2024-02-05 | 1100.0       | 6850.0        |
| 109      | 2024-02-10 | 400.0        | 7250.0        |
| 110      | 2024-02-15 | 950.0        | 8200.0        |
| 111      | 2024-02-20 | 2000.0       | 10200.0       |
| 112      | 2024-02-25 | 750.0        | 10950.0       |

8. SELECT employee_id, order_id, order_date, total_amount,
           SUM(total_amount) OVER (
               PARTITION BY employee_id
               ORDER BY order_date
           ) AS cumulative_sales
    FROM orders;

| employee_id | order_id | order_date | total_amount | cumulative_sales |
| ----------- | -------- | ---------- | ------------ | ---------------- |
| 1           | 101      | 2024-01-10 | 500.0        | 500.0            |
| 1           | 103      | 2024-01-15 | 1200.0       | 1700.0           |
| 1           | 107      | 2024-02-01 | 650.0        | 2350.0           |
| 1           | 111      | 2024-02-20 | 2000.0       | 4350.0           |
| 2           | 102      | 2024-01-11 | 700.0        | 700.0            |
| 2           | 106      | 2024-01-25 | 1500.0       | 2200.0           |
| 2           | 110      | 2024-02-15 | 950.0        | 3150.0           |
| 3           | 104      | 2024-01-18 | 300.0        | 300.0            |
| 3           | 108      | 2024-02-05 | 1100.0       | 1400.0           |
| 4           | 105      | 2024-01-20 | 900.0        | 900.0            |
| 4           | 109      | 2024-02-10 | 400.0        | 1300.0           |
| 4           | 112      | 2024-02-25 | 750.0        | 2050.0           |


9. SELECT customer_id, order_id, order_date, total_amount,
           LAG(total_amount) OVER (
               PARTITION BY customer_id
               ORDER BY order_date
           ) AS previous_order
    FROM orders;

| customer_id | order_id | order_date | total_amount | previous_order |
| ----------- | -------- | ---------- | ------------ | -------------- |
| 1           | 101      | 2024-01-10 | 500.0        |                |
| 1           | 103      | 2024-01-15 | 1200.0       | 500.0          |
| 1           | 108      | 2024-02-05 | 1100.0       | 1200.0         |
| 1           | 112      | 2024-02-25 | 750.0        | 1100.0         |
| 2           | 102      | 2024-01-11 | 700.0        |                |
| 2           | 107      | 2024-02-01 | 650.0        | 700.0          |
| 3           | 104      | 2024-01-18 | 300.0        |                |
| 3           | 109      | 2024-02-10 | 400.0        | 300.0          |
| 4           | 105      | 2024-01-20 | 900.0        |                |
| 4           | 110      | 2024-02-15 | 950.0        | 900.0          |
| 5           | 106      | 2024-01-25 | 1500.0       |                |
| 5           | 111      | 2024-02-20 | 2000.0       | 1500.0         |

10.  SELECT customer_id, order_id, order_date, total_amount,
           LEAD(total_amount) OVER (
               PARTITION BY customer_id
               ORDER BY order_date
           ) AS next_order
    FROM orders;

| customer_id | order_id | order_date | total_amount | next_order |
| ----------- | -------- | ---------- | ------------ | ---------- |
| 1           | 101      | 2024-01-10 | 500.0        | 1200.0     |
| 1           | 103      | 2024-01-15 | 1200.0       | 1100.0     |
| 1           | 108      | 2024-02-05 | 1100.0       | 750.0      |
| 1           | 112      | 2024-02-25 | 750.0        |            |
| 2           | 102      | 2024-01-11 | 700.0        | 650.0      |
| 2           | 107      | 2024-02-01 | 650.0        |            |
| 3           | 104      | 2024-01-18 | 300.0        | 400.0      |
| 3           | 109      | 2024-02-10 | 400.0        |            |
| 4           | 105      | 2024-01-20 | 900.0        | 950.0      |
| 4           | 110      | 2024-02-15 | 950.0        |            |
| 5           | 106      | 2024-01-25 | 1500.0       | 2000.0     |
| 5           | 111      | 2024-02-20 | 2000.0       |            |

11. SELECT customer_id, order_id, order_date, total_amount,
           total_amount -
           LAG(total_amount) OVER (
               PARTITION BY customer_id
               ORDER BY order_date
           ) AS difference
    FROM orders;

| customer_id | order_id | order_date | total_amount | difference |
| ----------- | -------- | ---------- | ------------ | ---------- |
| 1           | 101      | 2024-01-10 | 500.0        |            |
| 1           | 103      | 2024-01-15 | 1200.0       | 700.0      |
| 1           | 108      | 2024-02-05 | 1100.0       | -100.0     |
| 1           | 112      | 2024-02-25 | 750.0        | -350.0     |
| 2           | 102      | 2024-01-11 | 700.0        |            |
| 2           | 107      | 2024-02-01 | 650.0        | -50.0      |
| 3           | 104      | 2024-01-18 | 300.0        |            |
| 3           | 109      | 2024-02-10 | 400.0        | 100.0      |
| 4           | 105      | 2024-01-20 | 900.0        |            |
| 4           | 110      | 2024-02-15 | 950.0        | 50.0       |
| 5           | 106      | 2024-01-25 | 1500.0       |            |
| 5           | 111      | 2024-02-20 | 2000.0       | 500.0      |

12. SELECT order_id, order_date, total_amount,
           AVG(total_amount) OVER (
               ORDER BY order_date
               ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
           ) AS moving_avg
    FROM orders;

| order_id | order_date | total_amount | moving_avg  |
| -------- | ---------- | ------------ | ----------- |
| 101      | 2024-01-10 | 500.0        | 500.0       |
| 102      | 2024-01-11 | 700.0        | 600.0       |
| 103      | 2024-01-15 | 1200.0       | 800.0       |
| 104      | 2024-01-18 | 300.0        | 733.333333  |
| 105      | 2024-01-20 | 900.0        | 800.0       |
| 106      | 2024-01-25 | 1500.0       | 900.0       |
| 107      | 2024-02-01 | 650.0        | 1016.666667 |
| 108      | 2024-02-05 | 1100.0       | 1083.333333 |
| 109      | 2024-02-10 | 400.0        | 716.666667  |
| 110      | 2024-02-15 | 950.0        | 816.666667  |
| 111      | 2024-02-20 | 2000.0       | 1116.666667 |
| 112      | 2024-02-25 | 750.0        | 1233.333333 |

13. SELECT employee_id, employee_name, salary,
           NTILE(4) OVER (ORDER BY salary DESC) AS quartile
    FROM employees;

| employee_id | employee_name | salary  | quartile |
| ----------- | ------------- | ------- | -------- |
| 4           | Diana Prince  | 95000.0 | 1        |
| 3           | Charlie Brown | 90000.0 | 1        |
| 7           | George Miller | 85000.0 | 2        |
| 8           | Hannah Lee    | 82000.0 | 2        |
| 1           | Alice Johnson | 70000.0 | 3        |
| 2           | Bob Smith     | 65000.0 | 3        |
| 5           | Ethan Hunt    | 60000.0 | 4        |
| 6           | Fiona Green   | 58000.0 | 4        |

