# lua-dbt <img src="https://seeklogo.com/images/D/dbt-logo-500AB0BAA7-seeklogo.com.png" width="24" title="hover text">

[![dbt version](https://img.shields.io/static/v1?label=dbt&message=1.1.0&color=orange)](https://pypi.org/project/dbt-core/)
[![dbt adapter](https://img.shields.io/static/v1?label=dbt-adapter&message=clickhouse&color=yellow)](https://pypi.org/project/dbt-clickhouse/)
[![python version](https://img.shields.io/static/v1?label=python&message=3.10&color=blue)](https://www.python.org/downloads/release/python-3100/)

Luabase dbt models

## Local Development

Reguirements:

- Docker
- VS Code
- Familiarity with [Dev Containers](https://microsoft.github.io/code-with-engineering-playbook/developer-experience/devcontainers/)

### 1. Config Developer Credentials

Add a file named `devcontainer.env` to the `.devcontainer/` directory.

Copy the contents below to that file and fill out your developer credentials

```text
DBT_PROFILES_DIR=/workspaces/lua-dbt/

CH_SCHEMA=xxx
CH_USER=xxx
CH_PASSWORD=xxx
CH_HOST=xxx
```

| Value | Description |
|---|---|
| `CH_SCHEMA` | Dev schema/database in Clickhouse (e.g. dbt_mjr) |
| `CH_USER` | Clickhouse username (e.g. admin) |
| `CH_PASSWORD` | Clickhouse password |
| `CH_HOST` |Clickhouse host endpoint |

### 2. Open Folder in Remote Container

Link to marketplace extension [here](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

Run `CMD + P` to open up the search and type in `> Remote-Containers: Open Folder in Container...`

![gif](https://microsoft.github.io/vscode-remote-release/images/remote-containers-readme.gif)

### 3. Validate credentials worked

Run the debug command with dbt using 

```shell
$ dbt debug
```
or
```shell
$ dbt debug --profiles-dir ../
```

## Clone Table

Often during development, it is useful to clone a table/view/etc. (or a sample of one) so that you can experiment with changes to the table. While dbt provides an excellent way of creating development and production versions of derived tables, sometimes you also want to create a development clone of a source table.

Do to this you can use the custom `clone_table` macro:

```shell
$ dbt run-operation clone_table --args "{'database': 'staging', 'table': 'ethereum_abis', 'key': 'address'}"
```

This will create a view from the table specified above and store it in whatever schema/database you specified in the developer credentials.

So, if the developer database was set as `dbt_dev` the above command would create a new view `dbt_dev.staging__ethereum_abis`.
