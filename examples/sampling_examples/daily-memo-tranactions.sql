WITH 
  MEMO_RECORD AS (
  SELECT 
    block_timestamp,
    tx_signature AS signature
  FROM
    `solana-data-sandbox.crypto_solana_mainnet_us.Instructions`
  WHERE
    program = 'spl-memo' )
SELECT 
  DATE(MEMO_RECORD.block_timestamp) AS date,
  COUNT(DISTINCT MEMO_RECORD.signature) AS memo_count
FROM  
  `solana-data-sandbox.crypto_solana_mainnet_us.Transactions`
RIGHT JOIN
  MEMO_RECORD USING (signature)
WHERE 
  err IS NULL AND DATE(MEMO_RECORD.block_timestamp) != "1970-01-01"
GROUP BY 
  date
ORDER BY 
  date ASC;