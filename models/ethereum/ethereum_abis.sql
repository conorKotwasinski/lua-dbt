select
    address,
    abi,
    JSONExtract(details, 'name', 'String') as name
from {{ source('staging', 'ethereum_abis') }}
where JSONExtract(details, 'public', 'Boolean') == true
