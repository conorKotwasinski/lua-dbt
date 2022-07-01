#!/bin/bash

clone () {
    git clone -b main --single-branch https://github.com/luabase/lua-dbt
    cd lua-dbt
}

run_dbt () {
    echo "we runnning dbt!"
}

update_pg () {
    echo "we updating posgtres!"
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
