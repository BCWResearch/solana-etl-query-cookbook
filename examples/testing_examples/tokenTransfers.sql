-- 1.29 TB when run
SELECT *
FROM `testsolana_1.Token Transfers`
where block_slot = 80000000 and block_timestamp > '2021-01-01'