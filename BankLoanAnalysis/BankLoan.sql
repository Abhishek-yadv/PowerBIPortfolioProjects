/*********** Total Loan Application ******************/
SELECT COUNT(DISTINCT ID) AS Total_Loan_Application
FROM LoanData;

/*********** MTD Total Loan Application *************/
SELECT COUNT(DISTINCT ID) AS MTD_Total_Loan_Application
FROM LoanData
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)= 2021;

/*********** PMTD Total Loan Application *************/
SELECT COUNT(DISTINCT ID) AS MTD_Total_Loan_Application
FROM LoanData
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)= 2021;


/********** MOM Total Loan Application **************/
WITH MTD AS (
	SELECT COUNT(DISTINCT ID) AS MTD_Total_Loan_Application
	FROM LoanData
	WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)= 2021
),
PMTD AS (
	SELECT COUNT(DISTINCT ID) AS PMTD_Total_Loan_Application
	FROM LoanData
	WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)= 2021)
SELECT ((MTD.MTD_Total_Loan_Application - PMTD.PMTD_Total_Loan_Application)* 1.0/PMTD.PMTD_Total_Loan_Application) AS MOM_Total_Loan_Application
FROM MTD, PMTD;


/**************** Total Funded Amount ***************/
SELECT SUM(loan_amount) Total_Funded_Amount
FROM LoanData

/**************** MTD Total Funded Amount ***********/
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM LoanData
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)= 2021;

/**************** PMTD Total Funded Amount **********/
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM LoanData
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)= 2021;


/************** Total Amount Received ***************/
SELECT SUM(total_payment) AS Total_Amount_Received
FROM LoanData;

/************ MTD Total Amount Received ************/
SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM LoanData
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)= 2021;

/************ PMTD Total Payment Amount ************/
SELECT SUM(loan_amount) AS PMTD_Total_Amount_Received
FROM LoanData
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)= 2021;


/**************** AVG Interest Rate ****************/
SELECT ROUND(AVG(Int_Rate)*100, 4) AS AVG_Interest_Rate
FROM LoanData

/************ MTD AVG Interest Rate ************/
SELECT ROUND(AVG(Int_Rate)*100, 4) AS MTD_AVG_Interest_Rate
FROM LoanData
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)= 2021;

/************ PMTD AVG Interest Rate ************/
SELECT ROUND(AVG(Int_Rate)*100, 4) AS PMTD_AVG_Interest_Rate
FROM LoanData
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)= 2021;


/********************* AVG DTI ******************/
SELECT ROUND(AVG(DTI)*100, 4) AS AVG_DTI
FROM LoanData

/********************* MTD AVG DTI ******************/
SELECT ROUND(AVG(DTI)*100, 4) AS MTD_AVG_DTI
FROM LoanData
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)= 2021;

/********************* PMTD AVG DTI ******************/
SELECT ROUND(AVG(DTI)*100, 4) AS MTD_AVG_DTI
FROM LoanData
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)= 2021;

/********************* PMTD AVG DTI ******************/
SELECT ROUND(AVG(DTI)*100, 4) AS MTD_AVG_DTI
FROM LoanData
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)= 2021;


/*********************** Good Loan ******************/
SELECT
	((COUNT(CASE 
		WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id
	END))*1.0/COUNT(id))*100 AS Good_Loan_Percentage
FROM LoanData

/************** Good Loan Application ****************/
SELECT Count(id) AS Good_Loan_Application
FROM LoanData
WHERE Loan_Status = 'fully Paid' OR Loan_Status = 'Current'

/************** Good Loan Funded Amount ****************/
SELECT SUM(Loan_Amount) AS Good_Loan_Funded_Amount
FROM LoanData
WHERE Loan_Status = 'fully Paid' OR Loan_Status = 'Current'

/************** Good Loan Received Amount ****************/
SELECT SUM(Total_Payment) AS Good_Loan_Received_Amount
FROM LoanData
WHERE Loan_Status = 'fully Paid' OR Loan_Status = 'Current'


/*********************** Bad Loan ******************/
SELECT
	((COUNT(CASE 
		WHEN loan_status = 'Charged Off' THEN id
	END))*1.0/COUNT(id))*100 AS Bad_Loan_Percentage
FROM LoanData

/************** Bad Loan Application ****************/
SELECT Count(id) AS Bad_Loan_Application
FROM LoanData
WHERE loan_status = 'Charged Off'

/************** Bad Loan Funded Amount **************/
SELECT SUM(Loan_Amount) AS Good_Loan_Funded_Amount
FROM LoanData
WHERE loan_status = 'Charged Off'


/************* Bad Loan Recieved Amount **************/
SELECT SUM(Total_Payment) AS Good_Loan_Funded_Amount
FROM LoanData
WHERE loan_status = 'Charged Off'


/**************** Loan Summaray *****************/
SELECT
	Loan_Status,
	COUNT(ID) AS Total_Loan_applications,
	SUM(Total_Payment) AS Total_Amount_Received,
	SUM(Loan_amount) AS Total_Funded_Amount,
	AVG(Int_Rate * 100) AS Interest_Rate,
	AVG(DTI * 100) AS DTI
FROM LoanData
GROUP BY Loan_Status

/*************** Summaray By MTD Data ****************/
SELECT
	Loan_Status,
	COUNT(ID) AS Total_Loan_applications,
	SUM(Total_Payment) AS Total_Amount_Received,
	SUM(Loan_amount) AS Total_Funded_Amount
FROM LoanData
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)= 2021
GROUP BY Loan_Status

/*************** PMTD Data Summarization ****************/
SELECT
	Loan_Status,
	COUNT(ID) AS Total_Loan_applications,
	SUM(Total_Payment) AS Total_Amount_Received,
	SUM(Loan_amount) AS Total_Funded_Amount
FROM LoanData
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)= 2021
GROUP BY Loan_Status

/*************** Summary By Month ****************/
SELECT
    DATENAME(MONTH, Issue_Date) AS Month_Name,
	MONTH(Issue_Date) AS Month_Number,
    COUNT(ID) AS Total_Loan_Applications,
    SUM(Loan_Amount) AS Total_Funded_Amount,
	SUM(Total_Payment) AS Total_Amount_Received
FROM LoanData
GROUP BY MONTH(Issue_Date), DATENAME(MONTH, Issue_Date)
ORDER BY MONTH(Issue_Date)


/*************** Summary By State ****************/
SELECT
    address_state,
    COUNT(ID) AS Total_Loan_Applications,
    SUM(Loan_Amount) AS Total_Funded_Amount,
	SUM(Total_Payment) AS Total_Amount_Received
FROM LoanData
GROUP BY address_state
ORDER BY Total_Loan_Applications DESC

/*************** Overview Of Terms ****************/
SELECT
    term,
    COUNT(ID) AS Total_Loan_Applications,
    SUM(Loan_Amount) AS Total_Funded_Amount,
	SUM(Total_Payment) AS Total_Amount_Received
FROM LoanData
GROUP BY term
ORDER BY term

/*************** Overview Of Emp_Length ****************/
SELECT
    Emp_Length,
    COUNT(ID) AS Total_Loan_Applications,
    SUM(Loan_Amount) AS Total_Funded_Amount,
	SUM(Total_Payment) AS Total_Amount_Received
FROM LoanData
GROUP BY Emp_Length
ORDER BY Total_Loan_Applications DESC

/*************** Overview Of Purpose ****************/
SELECT
    Purpose,
    COUNT(ID) AS Total_Loan_Applications,
    SUM(Loan_Amount) AS Total_Funded_Amount,
	SUM(Total_Payment) AS Total_Amount_Received
FROM LoanData
GROUP BY Purpose
ORDER BY Total_Loan_Applications DESC

/*************** Overview Of Home_Ownership ****************/
SELECT
    Home_Ownership,
    COUNT(ID) AS Total_Loan_Applications,
    SUM(Loan_Amount) AS Total_Funded_Amount,
	SUM(Total_Payment) AS Total_Amount_Received
FROM LoanData
GROUP BY Home_Ownership
ORDER BY Total_Loan_Applications DESC


SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'salesdata';