-- 34.19 GB when run
SELECT *
FROM `crypto_solana_mainnet_us.Accounts`
where block_slot = 80000000 and block_timestamp > '2021-01-01'