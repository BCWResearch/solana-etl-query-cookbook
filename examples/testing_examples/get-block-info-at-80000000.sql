WITH BlockInfo AS (
  SELECT
    slot,
    block_timestamp,
    block_hash,
    leader,
    leader_reward,
    transaction_count,
    previous_block_hash
  FROM
    testsolana_1.Blocks
  WHERE
    slot = 80000000
    AND block_timestamp > '2021-01-01'
),
TransactionInfo AS (
  SELECT
    signature,
    block_slot,
    block_timestamp AS transaction_block_timestamp,
    log_messages,
    a.pubkey,
    fee
  FROM
    testsolana_1.Transactions
  CROSS JOIN
    UNNEST(accounts) AS a
  WHERE
    block_slot = 80000000
    AND block_timestamp > '2021-01-01'
),
BlockRewards AS (
  SELECT
    block_slot,
    commission,
    lamports,
    pubkey,
    reward_type
  FROM
    testsolana_1.`Block Rewards`
  WHERE
    block_slot = 80000000
    AND block_timestamp > '2021-01-01'
)
SELECT
  BlockInfo.slot,
  BlockInfo.block_timestamp,
  BlockInfo.block_hash,
  BlockInfo.leader,
  BlockInfo.leader_reward,
  BlockInfo.transaction_count,
  BlockInfo.previous_block_hash,
  TransactionInfo.signature,
  TransactionInfo.block_slot AS transaction_block_slot,
  TransactionInfo.transaction_block_timestamp,
  TransactionInfo.log_messages,
  TransactionInfo.pubkey AS account_pubkey,
  TransactionInfo.fee,
  BlockRewards.commission,
  BlockRewards.lamports,
  BlockRewards.pubkey AS reward_pubkey,
  BlockRewards.reward_type
FROM
  BlockInfo
LEFT JOIN
  TransactionInfo ON BlockInfo.slot = TransactionInfo.block_slot
LEFT JOIN
  BlockRewards ON BlockInfo.slot = BlockRewards.block_slot;