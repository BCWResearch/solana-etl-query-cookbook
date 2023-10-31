-- 1.27 TB when run
SELECT *
FROM `crypto_solana_mainnet_us.Block Rewards`
where block_slot = 80000000 and block_timestamp > '2021-01-01'