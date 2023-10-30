-- 6.01 GB when run
SELECT
  pubkey, lamports
FROM
  crypto_solana_mainnet_us.Accounts
ORDER BY
  lamports DESC
LIMIT
  1000;
