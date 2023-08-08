SELECT   TIMESTAMP_TRUNC(block_timestamp, MONTH) AS created_month,
         instruction_type,
         COUNT(DISTINCT TO_JSON_STRING((block_hash, index))) AS type_count
FROM     `solana-bq.test_usa.Instructions`
WHERE    instruction_type IS NOT NULL
AND      TIMESTAMP_TRUNC(block_timestamp, MONTH) IS NOT NULL
GROUP BY created_month,
         instruction_type
ORDER BY created_month,
         type_count DESC