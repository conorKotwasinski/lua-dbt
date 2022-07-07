select
    block_number,
    block_hash,
    block_timestamp,
    address,
    bytecode,
    function_sighashes,
    is_erc20,
    is_erc720
from {{ source('polygon', 'contracts_raw') }}
