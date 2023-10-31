-- 462.41 MB when run
SELECT   creator.address AS creator_address,
         COUNT(DISTINCT mint) AS mint_count
FROM     `crypto_solana_mainnet_us.Tokens`,
         UNNEST(`crypto_solana_mainnet_us.Tokens`.creators) AS creator
WHERE    creator.address IS NOT NULL
AND      is_nft = True
GROUP BY creator_address
ORDER BY mint_count DESC;