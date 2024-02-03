## KPI 1 : YEAR WISE LOAN AMOUNT STATS
SELECT 
    YEAR(last_pymnt_d) AS Year,
    CONCAT('$ ',
            ROUND(SUM(loan_amnt) / 100000, 2),
            ' Mn') AS Loan_amount
FROM
    finance_1
        JOIN
    finance_2 ON finance_1.id = finance_2.id
GROUP BY Year;

## KPI 2 : GRADE AND SUB-GRADE WISE REVOL_BAL
SELECT 
    a.grade AS grade,
    a.sub_grade AS sub_grade,
    CONCAT(' $ ',
            FORMAT(ROUND(SUM(b.revol_bal) / 100000, 2),
                2),
            ' Mn') AS Revol_bal
FROM
    finance_1 AS a
        JOIN
    finance_2 AS b ON a.id = b.id
GROUP BY grade , sub_grade
ORDER BY grade;

## KPI 3 : TOTAL_PAYMENT FOR VERIFIED STATUS VS TOTAL_PAYMENT FOR NON-VERIFIED STATUS
SELECT 
    a.verification_status AS verification_status,
    CONCAT('$',
            FORMAT(ROUND(SUM(b.total_pymnt)) / 1000000,
                2),
            'Mn') AS Total_payment
FROM
    finance_1 AS a
        JOIN
    finance_2 AS b ON a.id = b.id
GROUP BY verification_status;

## KPI 4 : STATE WISE AND LAST_CREDIT_PULL_D WISE LOAN STATUS
SELECT DISTINCT
    (a.addr_state) AS State,
    b.last_credit_pull_d AS Date,
    a.loan_status AS Loan_status
FROM
    finance_1 AS a
        JOIN
    finance_2 AS b ON a.id = b.id;

## KPI 5 : HOME OWNERSHIP VS LAST PAYMENT DATE STATS
SELECT DISTINCT
    (a.home_ownership) AS Home_Ownership,
    COUNT(home_ownership) AS Total,
    YEAR(b.last_pymnt_d) AS Year
FROM
    finance_1 AS a
        JOIN
    finance_2 AS b ON a.id = b.id
GROUP BY home_ownership , year
ORDER BY home_ownership;

##KPI 6 : PURPOSE FOR LOAN AMOUNT
SELECT 
    purpose,
    CONCAT('$ ',
            FORMAT(ROUND(SUM(loan_amnt) / 100000, 2),
                2),
            ' Mn') AS Loan_amnt,
    CONCAT(ROUND(SUM(loan_amnt) * 100 / (SELECT 
                            SUM(loan_amnt)
                        FROM
                            finance_1),
                    2),
            '%') AS Percentage
FROM
    finance_1
GROUP BY purpose;

## KPI 7 : STATE WISE CUSTOMERS
SELECT DISTINCT
    (addr_state) AS State, COUNT(id) AS Total_customers
FROM
    finance_1
GROUP BY state;

## KPI 8 : AVERAGE INTEREST RATE AND TOTAL LOAN AMOUNT
SELECT 
    CONCAT(ROUND(AVG(int_rate), 2), ' %') AS Average_int_rate,
    CONCAT('$ ',
            FORMAT(ROUND(SUM(loan_amnt) / 1000000, 2),
                2),
            ' Mn') AS Total_loan_amnt
FROM
    finance_1
;