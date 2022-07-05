{# Model description #}
{% docs blocks_model_description %}

Blocks are batches of transactions with a hash of the previous block in the chain.

{% enddocs %}

{# Column descriptions #}
{% docs block_number %}

The length of the blockchain (count of blocks)

{% enddocs %}


{% docs block_timestamp %}

The time when the block was mined

{% enddocs %}


{% docs block_hash %}

A unique identifier for the block

{% enddocs %}


{% docs parent_hash %}

The hash of the parent (prior) block

{% enddocs %}


{% docs nonce %}

The nonce used to mine the block

{% enddocs %}


{% docs sha3_uncles %}

A sibling block of the parent block

{% enddocs %}


{% docs logs_bloom %}

The bloom filter for the logs in the block

{% enddocs %}


{% docs transactions_root %}

The root hash of the Merkle tree of all the transactions in the block (32 byte string)

{% enddocs %}


{% docs state_root %}

The root of the state trie at the end of the block

{% enddocs %}


{% docs receipts_root %}

The hash of the root node of the trie that contains the receipts of all transactions listed in this block

{% enddocs %}


{% docs miner %}

The address of the miner who mined the block

{% enddocs %}


{% docs difficulty %}

The effort required to mine the block

{% enddocs %}


{% docs total_difficulty %}

Cumulative difficulty of all blocks until the current block

{% enddocs %}


{% docs size %}

Size of block in bytes

{% enddocs %}


{% docs extra_data %}

An optional 32-byte space to store extra data

{% enddocs %}


{% docs gas_used %}

The amount of gas used by the block

{% enddocs %}


{% docs gas_limit %}

The gas limit allowed in the block

{% enddocs %}


{% docs transaction_count %}

Number of transactions in the block

{% enddocs %}


{% docs base_fee_per_gas %}

The base fee for this block (see EIP-1559)

{% enddocs %}
