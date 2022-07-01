# lua-dbt <img src="https://seeklogo.com/images/D/dbt-logo-500AB0BAA7-seeklogo.com.png" width="24" title="hover text">

[![dbt version](https://img.shields.io/static/v1?label=dbt&message=1.1.0&color=orange)](https://pypi.org/project/dbt-core/)
[![dbt adapter](https://img.shields.io/static/v1?label=dbt-adapter&message=clickhouse&color=yellow)](https://pypi.org/project/dbt-clickhouse/)

## dbt Command Cheatsheet

| Command                                | Description                                                                                   |
|----------------------------------------|-----------------------------------------------------------------------------------------------|
| `dbt run`                              | Run the models                                                                                |
| `dbt run --select ethereum`            | Run all models under the `ethereum/` directory                                                |
| `dbt run --select ethereum.blocks`     | Run just the `blocks` model under the `ethereum/` directory                                   |
| `dbt run --select blocks`              | Run the model named `blocks`                                                                  |
| `dbt test`                             | Run all dbt tests (schema and custom)                                                         |
| `dbt test --select ethereum`           | Run all tests for all models under the `ethereum/` directory                                  |
| `dbt test --select ethereum.blocks`    | Run all tests for the `blocks` model under the `ethereum/` directory                          |
| `dbt test --select blocks`             | Run all tests for the model named `blocks`                                                    |
| `dbt build`                            | Run all models and tests for all models                                                       |
| `dbt build --select ethereum`          | Run all models and tests for all models under the `ethereum/` directory                       |
| `dbt build --select ethereum.blocks`   | Run all models and tests for the `blocks` model under the `ethereum/` directory               |
| `dbt build --select blocks`            | Run all models and tests for the model named `blocks`                                         |
| `dbt compile`                          | Compile/hydrate but do not run or test for all models                                         |
| `dbt compile --select ethereum`        | Compile/hydrate but do not run or test for all models under the `ethereum/` directory         |
| `dbt compile --select ethereum.blocks` | Compile/hydrate but do not run or test for the `blocks` model under the `ethereum/` directory |
| `dbt compile --select blocks`          | Compile/hydrate but do not run or test for the model named `blocks`                           |
| `dbt debug`                            | Ensure profile configurations work and connection to warehouse is successful                  |

## Local Development

**Note**: It is recommended to use a virtual environment

1. Install dependencies

```shell
pip install -r requirements.txt
```

2. Create a file called `.env` in the root of the directory

```shell
touch .env
```

3. Add necessary environment variables to the file

**Note**: Replace `xxx` with the values found in 1Password. Keep `DBT_PROFILES_DIR` as is.

```text
DBT_PROFILES_DIR=.
CH_PASSWORD=xxx
CH_HOST=xxx
```

4. Source the `.env` file

```shell
export $(grep -v '^#' .env | xargs)
```

5. Ensure the credentials work

```shell
dbt debug
```

6. Build all models and run tests before you start developing to ensure everything is working prior to you making
   changes

**Note**: Views will show in test databases instead of production. So if you're building there Ethereum models, the
views will appear in `ethereum_test` instead of `ethereum`.

```shell
dbt build
```

## 🚧 DANGER ZONE 🚧 Production Build

**Note**: It is highly recommended that you let the CI pipeline handle deployments to production. You should not do this
manually unless you have a compelling reason.

To run or test production views, you need to use the production target defined in the `profiles.yml` file. To do this by
using the `--target`/`-t` flag when calling dbt commands

```shell
dbt build --target prod
dbt build -t prod
```

## dbt Resources

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
