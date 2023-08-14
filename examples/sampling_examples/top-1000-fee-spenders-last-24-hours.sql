-- 7.02 TB when run
WITH
  GetTopFeeSpenders AS (
    SELECT
      t.fee,
      a.pubkey AS account_pubkey,
      t.block_timestamp
    FROM
      testsolana_1.Transactions t
      CROSS JOIN 
        UNNEST (t.accounts) AS a
  ),
  AggregatedData AS (
    SELECT
      account_pubkey,
      SUM(
        CASE
          WHEN block_timestamp >= TIMESTAMP_SUB (CURRENT_TIMESTAMP(), INTERVAL 1 HOUR) 
          THEN fee
          ELSE 0
        END
      ) AS total_fee_1_hour,
      SUM(
        CASE
          WHEN block_timestamp >= TIMESTAMP_SUB (CURRENT_TIMESTAMP(), INTERVAL 24 HOUR) 
          THEN fee
          ELSE 0
        END
      ) AS total_fee_24_hours,
      COUNT(*) AS total_transactions_1_hour,
      COUNT(
        CASE
          WHEN block_timestamp >= TIMESTAMP_SUB (CURRENT_TIMESTAMP(), INTERVAL 24 HOUR) 
          THEN 1
        END
      ) AS total_transactions_24_hours
    FROM
      GetTopFeeSpenders
    GROUP BY
      account_pubkey
  )
SELECT
  account_pubkey,
  total_fee_1_hour,
  total_fee_24_hours,
  total_transactions_1_hour,
  total_transactions_24_hours
FROM
  AggregatedData
ORDER BY
  total_fee_1_hour DESC,
  total_fee_24_hours DESC
LIMIT
  1000;