#!/bin/bash

clone () {
    git clone -b 'test/pipeline' --single-branch https://github.com/luabase/lua-dbt
    cd lua-dbt
}

run_dbt () {
    dbt run --profiles-dir=. --profile luabase --select path:models/test
}

update_pg () {
    python updateLuaSchema.py
}


case "$1" in
    "run_dbt")
        clone
        run_dbt
        ;;
    "update_pg")
        clone
        update_pg
        ;;
    "run_dbt_and_update")
        clone
        run_dbt && update_pg
        ;;
    *)
        echo "Error, command not recognized: $1"
        echo "Possible commands 'run_dbt', 'update_pg', 'run_dbt_and_update'"
        ;;
esac
