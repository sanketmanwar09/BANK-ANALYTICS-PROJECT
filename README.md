# Bank Analytics 

![](bankimage.jpg)
![](Screenshot(143).png)

## Table of Contents
---
- [ Project Overview]( #project-overview)
- [Data Sources](#data-sources)
- [ Tools](#tools)
- [Data Cleaning](#data-cleaning)
- [KPI](#kpi)
- [Findings](#findings)


### Project Overview
---

This bank analytics project aims to provide insights into the overall performance of the bank. By analyzing various aspects of the sales data, we seek to identify trend , make data-driven recommendations and gain a deeper understanding of the bank's performance.


### Data Sources
---

In this analysis two data sets were used which contained detailed information about the bank.
- "Finance_1.csv"
- "Finance_2.csv"
### Tools
---
- Excel - Data Cleaning
- MySQL - Data Analysis
- Power BI - Creatin Reports


### Data Cleaning
---

In the initial data preparation phase , we performed the following tasks:
1. Data loading and inspection
2. Handling missing values
3. Data cleaning and formatting

### KPI
---
1. Year wise loan amount stats
2. Grade and sub-grade wise revol_bal
3. Total payment for verified status vs total payment for non-verified status
4. state wise and last_credit_pull_date wise loan status
5. Home ownership vs last payment date stats
6. Purpose for loan amount
7. State wise customers
8. Average interest rate and total loan amount

### Data Analysis
---
- Loan amount was highest in the year 2013(104 Mn) followed by 2014(99Mn),2012(97Mn),2011(51Mn),2015(35Mn),2016(33Mn),2009(6Mn) and 2008(1Mn)
- Out of the total revol_bal, Grade B has the highest(131Mn) followed by Grade A(115 Mn), Grade C(110 Mn), Grade D(75 Mn),Grade E(48 Mn),Grade F(19 Mn)and Grade G(7 Mn)
- Out of 39717 records for home_ownership ,39,646 are registered. Out of this record , maximum people live on Rental basis(18847) followed by Mortgage(17645),        Own(3053),Other(95) and None(3)
- Out of Total $446 Mn Loan Amount , 358 Mn is fully paid, 68 Mn is charged off and the current status is 19 Mn
- Out of Total accounts 68.19% are Verified (326.19 Mn) and 31.81% are Non-Verified(154.55 Mn)




.
 

















```
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
GROUP BY state
order by state ;

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
```

```
POWER BI

```






### Findings
The analysis results are summarized as follows:
- Loan amount was highest in the year 2013(104 Mn) followed by 2014(99Mn),2012(97Mn),2011(51Mn),2015(35Mn),2016(33Mn),2009(6Mn) and 2008(1Mn)
- Out of Total accounts 68.19% are Verified (326.19 Mn) and 31.81% are Non-Verified(154.55 Mn)
- Out of the total revol_bal, Grade B has the highest(131Mn) followed by Grade A(115 Mn), Grade C(110 Mn), Grade D(75 Mn),Grade E(19 Mn) and Grade F(7 Mn)
- Out of 39717 records for home_ownership ,39,646 are registered. Out of this record , maximum people live on Rental basis(18847) followed by Mortgage(17645), Own(3053),    Other(95) and None(3)
- Out of Total $446 Mn Loan Amount , 358 Mn is fully paid, 68 Mn is charged off and the current status is 19 Mn.
- Top 5 purposes for loan were debt_consolidation(2366 Mn) followed by home_improvement(343.35 Mn),other(322.14 Mn),small_business(248.01 Mn) and major_purchase(178.36 Mn)
- Top 5 state wise total_customers were CA(7099) followed BY NY(3812),FL(2866),TX(2727) and NJ(1850).
  



  



