-- 2.14 TB when run
WITH
  GetTopFeeSpenders AS (
  SELECT
    t.fee,
    a.pubkey AS account_pubkey,
    t.block_timestamp
  FROM
    crypto_solana_mainnet_us.Transactions t
  CROSS JOIN
    UNNEST (t.accounts) AS a ),
  AggregatedData AS (
  SELECT
    account_pubkey,
    SUM(CASE
        WHEN block_timestamp >= TIMESTAMP_SUB (CURRENT_TIMESTAMP(), INTERVAL 24 HOUR) THEN fee
      ELSE
      0
    END
      ) AS total_fee_24_hours,
    SUM(CASE
        WHEN block_timestamp >= TIMESTAMP_SUB (CURRENT_TIMESTAMP(), INTERVAL 24 HOUR) THEN 1
      ELSE
      0
    END
      ) AS total_transactions_24_hours
  FROM
    GetTopFeeSpenders
  WHERE
    block_timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 24 HOUR)
  GROUP BY
    account_pubkey ),
  FinalAggregatedData AS (
  SELECT
    account_pubkey,
    SUM(total_fee_24_hours) AS total_fee_24_hours,
    SUM(total_transactions_24_hours) AS total_transactions_24_hours
  FROM
    AggregatedData
  GROUP BY
    account_pubkey )
SELECT
  account_pubkey,
  total_fee_24_hours,
  total_transactions_24_hours
FROM
  FinalAggregatedData
ORDER BY
  total_fee_24_hours DESC
LIMIT
  1000;