#!/bin/bash

clone () {
    local branch="$1"
    git clone -b $branch --single-branch https://github.com/luabase/lua-dbt
    cd lua-dbt
}

run_dbt () {
    if [[ "$1" == "test" ]]
    then
        dbt build --profiles-dir=. --profile luabase --target prod
    else
        dbt run --profiles-dir=. --profile luabase --target prod
    fi
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
        clone main
        run_dbt && update_pg
        ;;
    "run_dbt_and_update_test")
        clone 'test/pipeline'
        run_dbt 'test' && update_pg
        ;;
    *)
        echo "Error, command not recognized: $1"
        echo "Possible commands 'run_dbt', 'update_pg', 'run_dbt_and_update', 'run_dbt_and_update_test'"
        ;;
esac
