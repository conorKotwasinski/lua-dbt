{# Model description #}
{% docs transactions_model_description %}

Transactions are cryptographically signed instructions from accounts.
An account will initiate a transaction to update the state of the network.

{% enddocs %}


{# Column descriptions #}
{% docs transaction_hash %}

With the signature hash, the transaction can be cryptographically proven that it came from the sender and submitted to
the network.

{% enddocs %}


{% docs transaction_nonce %}

The nonce is used to ensure that each transaction is unique.

{% enddocs %}


{% docs transaction_index %}

Index of this transaction within the block

{% enddocs %}


{% docs to_address %}

The receiving address

{% enddocs %}


{% docs from_address %}

The sending address

{% enddocs %}


{% docs transaction_value %}

The amount transferred from sender to recipient

{% enddocs %}


{% docs gas %}

The fee required to conduct a transaction

{% enddocs %}


{% docs gas_price %}

Gas price per unit.

{% enddocs %}


{% docs max_fee_per_gas %}

Maximum limit user is willing to pay for their transaction to be executed.

{% enddocs %}


{% docs max_priority_fee_per_gas %}

A fee (tip) to incentivize miners to include a transaction in the block.

{% enddocs %}


{% docs transaction_type %}

0 = Legacy, 1 = Access List, 2 = Dynamic Fee

{% enddocs %}