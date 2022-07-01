select
    block_timestamp,
    block_number,
    block_hash,
    address,
    bytecode,
    function_sighashes,
    is_erc20,
    is_erc721
from {{ source('avalanche', 'contracts_raw') }}
