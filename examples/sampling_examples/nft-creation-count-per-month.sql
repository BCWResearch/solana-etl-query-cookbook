SELECT TIMESTAMP_TRUNC(block_timestamp, MONTH) AS created_month,
       COUNT(mint)                             AS nft_create_count
FROM   `solana-bq.test_usa.Tokens`
WHERE  is_nft = True
GROUP  BY created_month
ORDER  BY created_month DESC 