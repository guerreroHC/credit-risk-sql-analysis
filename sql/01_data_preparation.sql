-- =====================================================
-- CREDIT RISK ANALYSIS
-- 01. DATA PREPARATION
-- =====================================================

-- Create clean table with target variable

DROP TABLE IF EXISTS loans_clean;

CREATE TABLE loans_clean AS
SELECT
    *,
    CASE
        WHEN loan_status IN (
            'Fully Paid',
            'Current',
            'Does not meet the credit policy. Status:Fully Paid'
        ) THEN 0

        WHEN loan_status IN (
            'Charged Off',
            'Default',
            'Does not meet the credit policy. Status:Charged Off',
            'Late (31-120 days)'
        ) THEN 1

        ELSE NULL
    END AS default_flag
FROM loans_raw
WHERE loan_status NOT IN (
    'In Grace Period',
    'Late (16-30 days)'
);

-- Create analytical table

DROP TABLE IF EXISTS loans_final;

CREATE TABLE loans_final AS
SELECT
    CAST(NULLIF(loan_amnt, '') AS DOUBLE PRECISION) AS loan_amnt,
    CAST(NULLIF(funded_amnt, '') AS DOUBLE PRECISION) AS funded_amnt,
    CAST(LEFT(TRIM(term), 2) AS INTEGER) AS term_months,
    CAST(NULLIF(int_rate, '') AS DOUBLE PRECISION) AS int_rate,
    CAST(NULLIF(installment, '') AS DOUBLE PRECISION) AS installment,

    grade,
    sub_grade,
    purpose,
    application_type,

    CAST(NULLIF(annual_inc, '') AS DOUBLE PRECISION) AS annual_inc,
    home_ownership,
    emp_length,
    verification_status,
    addr_state,

    CAST(NULLIF(dti, '') AS DOUBLE PRECISION) AS dti,
    CAST(NULLIF(delinq_2yrs, '') AS INTEGER) AS delinq_2yrs,
    CAST(NULLIF(inq_last_6mths, '') AS INTEGER) AS inq_last_6mths,
    CAST(NULLIF(open_acc, '') AS INTEGER) AS open_acc,
    CAST(NULLIF(total_acc, '') AS INTEGER) AS total_acc,
    CAST(NULLIF(REPLACE(revol_util, '%', ''), '') AS DOUBLE PRECISION) AS revol_util,
    CAST(NULLIF(acc_now_delinq, '') AS INTEGER) AS acc_now_delinq,
    CAST(NULLIF(mort_acc, '') AS INTEGER) AS mort_acc,
    CAST(NULLIF(tot_cur_bal, '') AS DOUBLE PRECISION) AS tot_cur_bal,

    TO_DATE(issue_d, 'Mon-YYYY') AS issue_date,
    CAST(default_flag AS INTEGER) AS default_flag
FROM loans_clean;