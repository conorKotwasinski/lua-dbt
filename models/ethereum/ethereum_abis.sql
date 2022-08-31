select
    address,
    name,
    abi,
    base64Decode(source_code) as source_code
from {{ source('contract', 'details') }}
where public
    and source = 'https://api.etherscan.io'
