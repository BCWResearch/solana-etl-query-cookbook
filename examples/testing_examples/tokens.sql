-- 1.42 GB when run
SELECT *
FROM `testsolana_1.Tokens`
where block_slot = 80000000 and block_timestamp > '2021-01-01'