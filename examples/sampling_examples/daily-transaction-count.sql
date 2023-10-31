-- 211.52 GB when run
WITH
  daily_transactions AS (
  SELECT
    DATE(block_timestamp) AS date,
    COUNT(*) AS count
  FROM
    `crypto_solana_mainnet_us.Transactions`
  GROUP BY
    date )
SELECT
  DATE_TRUNC(date, WEEK) AS week,
  CAST(AVG(count) AS INT64) AS count
FROM
  daily_transactions
GROUP BY
  week
ORDER BY
  week