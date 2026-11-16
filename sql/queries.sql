
-- VALIDATION 1
-- Business question:
-- How many records exist in each PesaPap database table?

SELECT 'users' AS table_name, COUNT(*) AS record_count
FROM users

UNION ALL

SELECT 'transactions', COUNT(*)
FROM transactions

UNION ALL

SELECT 'experiment', COUNT(*)
FROM experiment;

-- QUESTION A
-- Business question:
-- What is the total transaction volume and gross
-- transaction value processed by PesaPap?

SELECT
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS gross_transaction_value_kes,
    ROUND(AVG(amount), 2) AS average_transaction_value_kes
FROM transactions;

-- QUESTION B
-- Business question:
-- How do transaction volume, gross transaction value,
-- and active transacting users vary by month?

SELECT
    strftime('%Y-%m', txn_date) AS transaction_month,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT user_id) AS active_users,
    ROUND(SUM(amount), 2) AS gross_transaction_value_kes,
    ROUND(AVG(amount), 2) AS average_transaction_value_kes
FROM transactions
GROUP BY strftime('%Y-%m', txn_date)
ORDER BY transaction_month;

-- QUESTION C
-- Business question:
-- Which PesaPap products generate the highest transaction
-- volume and gross transaction value?

SELECT
    product,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT user_id) AS unique_users,
    ROUND(SUM(amount), 2) AS gross_transaction_value_kes,
    ROUND(AVG(amount), 2) AS average_transaction_value_kes,
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM transactions),
        2
    ) AS transaction_share_pct
FROM transactions
GROUP BY product
ORDER BY gross_transaction_value_kes DESC;

-- QUESTION D
-- Business question:
-- How many users were acquired through each channel,
-- and what percentage of all registered users do they represent?

SELECT
    acquisition_channel,
    COUNT(*) AS total_users,
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM users),
        2
    ) AS user_share_pct
FROM users
GROUP BY acquisition_channel
ORDER BY total_users DESC;

-- QUESTION E
-- Business question:
-- How does transaction activity and value differ
-- across customer acquisition channels?

SELECT
    u.acquisition_channel,
    COUNT(DISTINCT u.user_id) AS transacting_users,
    COUNT(t.txn_id) AS total_transactions,
    ROUND(SUM(t.amount), 2) AS gross_transaction_value_kes,
    ROUND(AVG(t.amount), 2) AS average_transaction_value_kes
FROM users AS u
INNER JOIN transactions AS t
    ON u.user_id = t.user_id
GROUP BY u.acquisition_channel
ORDER BY gross_transaction_value_kes DESC;

-- QUESTION F
-- Business question:
-- How many transactions occurred before the associated
-- user's signup date, and what percentage of all
-- transactions do they represent?

SELECT
    COUNT(*) AS total_transactions,
    SUM(
        CASE
            WHEN date(t.txn_date) < date(u.signup_date)
            THEN 1
            ELSE 0
        END
    ) AS pre_signup_transactions,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN date(t.txn_date) < date(u.signup_date)
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS pre_signup_pct
FROM transactions AS t
INNER JOIN users AS u
    ON t.user_id = u.user_id;

-- QUESTION G
-- Business question:
-- How has monthly transaction volume changed compared
-- with the previous month?

-- Techniques: CTE, CASE WHEN, LAG window function.

WITH monthly_transactions AS (
    SELECT
        strftime('%Y-%m', txn_date) AS transaction_month,
        COUNT(*) AS total_transactions
    FROM transactions
    GROUP BY strftime('%Y-%m', txn_date)
),
monthly_comparison AS (
    SELECT
        transaction_month,
        total_transactions,
        LAG(total_transactions) OVER (
            ORDER BY transaction_month
        ) AS previous_month_transactions
    FROM monthly_transactions
)
SELECT
    transaction_month,
    total_transactions,
    previous_month_transactions,
    CASE
        WHEN previous_month_transactions IS NULL
             OR previous_month_transactions = 0
        THEN NULL
        ELSE ROUND(
            100.0 *
            (total_transactions - previous_month_transactions)
            / previous_month_transactions,
            2
        )
    END AS month_over_month_growth_pct
FROM monthly_comparison
ORDER BY transaction_month;


-- QUESTION H
-- Business question:
-- How are customers distributed across transaction
-- frequency segments, and what is their transaction value?
--
-- Techniques: CTE, CASE WHEN, LAG window function.

WITH ordered_transactions AS (
    SELECT
        user_id,
        txn_id,
        amount,
        txn_date,
        LAG(txn_date) OVER (
            PARTITION BY user_id
            ORDER BY txn_date, txn_id
        ) AS previous_txn_date
    FROM transactions
),

customer_activity AS (
    SELECT
        user_id,
        COUNT(*) AS transaction_count,
        SUM(amount) AS total_transaction_value,
        AVG(
            julianday(txn_date) -
            julianday(previous_txn_date)
        ) AS avg_days_between_transactions
    FROM ordered_transactions
    GROUP BY user_id
),

customer_segments AS (
    SELECT
        user_id,
        transaction_count,
        total_transaction_value,
        avg_days_between_transactions,
        CASE
            WHEN transaction_count >= 6
                THEN 'High Frequency'
            WHEN transaction_count BETWEEN 3 AND 5
                THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_segment
    FROM customer_activity
)

SELECT
    frequency_segment,
    COUNT(*) AS customer_count,
    SUM(transaction_count) AS total_transactions,
    ROUND(SUM(total_transaction_value), 2)
        AS gross_transaction_value_kes,
    ROUND(AVG(avg_days_between_transactions), 2)
        AS avg_days_between_transactions
FROM customer_segments
GROUP BY frequency_segment
ORDER BY
    CASE frequency_segment
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        ELSE 3
    END;

