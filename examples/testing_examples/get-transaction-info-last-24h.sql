-- 691.01 MB when run 
SELECT
  (
    SELECT
      COUNT(*)
    FROM
      crypto_solana_mainnet_us.Transactions
    WHERE
      block_timestamp >= TIMESTAMP_SUB (CURRENT_TIMESTAMP(), INTERVAL 24 HOUR)
      AND block_timestamp <= CURRENT_TIMESTAMP()
  ) AS transaction_count,
  (
    SELECT
      SUM(fee)
    FROM
      crypto_solana_mainnet_us.Transactions
    WHERE
      block_timestamp >= TIMESTAMP_SUB (CURRENT_TIMESTAMP(), INTERVAL 24 HOUR)
      AND block_timestamp <= CURRENT_TIMESTAMP()
  ) AS total_fees,
  (
    SELECT
      AVG(fee)
    FROM
      crypto_solana_mainnet_us.Transactions
    WHERE
      block_timestamp >= TIMESTAMP_SUB (CURRENT_TIMESTAMP(), INTERVAL 24 HOUR)
      AND block_timestamp <= CURRENT_TIMESTAMP()
  ) AS average_fee;