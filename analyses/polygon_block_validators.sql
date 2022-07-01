select distinct
    block_number,
    replace(topics[4], '000000000000000000000000', '') as validator
from {{ source('polygon', 'logs_raw') }}
where address = '0x0000000000000000000000000000000000001010'
    and topics[1] = '0x4dfe1bbbcf077ddc3e01291eea2d5c70c2b422b415d95645b9adcfd678cb1d63'
from {{ source('polygon', 'logs_raw') }}