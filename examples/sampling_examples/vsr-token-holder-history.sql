WITH
  VSRTokenInformation AS (
    SELECT
      tx_signature AS signature,
      update_authority
    FROM
      `solana-bq.test_usa.Tokens`
  )
SELECT DISTINCT
  block_timestamp,
  ptb.owner AS holder,
FROM
  `solana-bq.test_usa.Transactions` AS Transactions
  CROSS JOIN 
    UNNEST(post_token_balances) AS ptb
LEFT JOIN 
  VSRTokenInformation USING (signature)
WHERE 
  ptb.owner != VSRTokenInformation.update_authority
ORDER BY
  block_timestamp DESC,
  holder ASC;