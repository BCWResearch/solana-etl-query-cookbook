-- 1.42 GB when run
SELECT *
FROM `crypto_solana_mainnet_us.Tokens`
where block_slot = 80000000 and block_timestamp > '2021-01-01'