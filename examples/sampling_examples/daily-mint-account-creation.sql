SELECT
  DATE(block_timestamp) AS mint_date,
  COUNT(tx_signature) AS mint_count
FROM
  `solana-data-sandbox.crypto_solana_mainnet_us.Accounts`
WHERE 
  account_type = 'mint'
GROUP BY 
  mint_date
ORDER BY 
  mint_date ASC;