select
    block_number,
    block_timestamp,
    block_hash,
    address,
    bytecode,
    function_sighashes,
    is_erc20,
    is_erc721
from {{ source('ethereum', 'contracts_raw') }}
