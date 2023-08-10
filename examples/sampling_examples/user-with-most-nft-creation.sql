SELECT   creator.address AS creator_address,
         COUNT(DISTINCT mint) AS mint_count
FROM     `solana-bq.test_usa.Tokens`,
         UNNEST(`solana-bq.test_usa.Tokens`.creators) AS creator
WHERE    creator.address IS NOT NULL
AND      is_nft = True
GROUP BY creator_address
ORDER BY mint_count DESC;