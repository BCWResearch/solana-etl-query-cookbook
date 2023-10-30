-- 423.12 GB when run
SELECT
  'solana' AS chain,
  COUNT(*) / (24 * 60 * 60 / COUNT(*) OVER (PARTITION BY DATE(block_timestamp))) AS throughput,
  block_timestamp AS time
FROM
  `testsolana_1.Transactions` AS transactions
GROUP BY
  transactions.block_slot,
  transactions.block_timestamp
ORDER BY
  throughput DESC
LIMIT
  1