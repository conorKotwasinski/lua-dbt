FROM python:3.10 as base-reqs
ARG git_short_sha
ENV GIT_SHORT_SHA="${git_short_sha}"
COPY requirements.txt /
RUN pip3 --default-timeout=600 install -r requirements.txt

FROM base-reqs as project
ENV CH_SCHEMA=default CH_USER=admin CH_HOST=lua-2.luabase.altinity.cloud
COPY lua_dbt.sh /
ENTRYPOINT ["/lua_dbt.sh"]
