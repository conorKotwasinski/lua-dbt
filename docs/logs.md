{# Model description #}
{% docs logs_model_description %}

Logs are a cheap way to store data on-chain.
An example is using logs to store historical data that can be rendered by a frontend.

{% enddocs %}


{# Column descriptions #}
{% docs log_index %}

Integer of the event index position in the block

{% enddocs %}


{% docs log_address %}

Address this event originated from

{% enddocs %}


{% docs log_data %}

The data containing non-indexed log parameter

{% enddocs %}


{% docs topic %}

Topic 1-3 contains indexed parameters of the log

{% enddocs %}
