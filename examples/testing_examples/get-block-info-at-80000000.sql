SELECT
    Account.pubkey AS account_pubkey,
    Block.slot,
    Block.block_timestamp,
    Block.block_hash,
    Block.leader,
    Block.leader_reward,
    Block.transaction_count,
    Block.previous_block_hash,
    TransactionInfo.signature,
    TransactionInfo.block_slot AS transaction_block_slot,
    TransactionInfo.block_timestamp AS transaction_block_timestamp,
    TransactionInfo.log_messages,
    TransactionInfo.fee,
    BlockRewards.commission,
    BlockRewards.lamports,
    BlockRewards.pubkey AS reward_pubkey,
    BlockRewards.reward_type
FROM
    crypto_solana_mainnet_us.Blocks AS Block
LEFT JOIN
    crypto_solana_mainnet_us.Transactions AS TransactionInfo
ON
    Block.slot = TransactionInfo.block_slot
LEFT JOIN
    crypto_solana_mainnet_us.`Block Rewards` AS BlockRewards
ON
    Block.slot = BlockRewards.block_slot
LEFT JOIN
    UNNEST(TransactionInfo.accounts) AS Account
ON
    true
WHERE
    Block.slot = 80000000
    AND Block.block_timestamp > '2021-01-01'
    AND TransactionInfo.block_slot = 80000000
    AND TransactionInfo.block_timestamp > '2021-01-01'
    AND BlockRewards.block_slot = 80000000
    AND BlockRewards.block_timestamp > '2021-01-01';
