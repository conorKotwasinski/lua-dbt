import os
import sys
import requests

PROD = "https://lua-dbt-services-backend-msgn5tdnsa-uc.a.run.app/api/v1/jobs/f7264201da2146e3a63bf3acff1d7a4f/trigger"
QA = "https://lua-dbt-services-backend-msgn5tdnsa-uc.a.run.app/api/v1/jobs/f7264201da2146e3a63bf3acff1d7a4f/trigger"

if __name__ == "__main__":
    # Retrieve environment variables
    target = os.getenv("TARGET", "dev")
    git_branch = os.getenv("GH_BRANCH", "main")
    url = PROD if target == "prod" else QA
    url = f"{url}?git_branch={git_branch}"

    # Trigger job
    res = requests.get(url=url)
    status = res.json().get("status_message", "failed")
    run_id = res.json().get("id")

    # Parse results
    env_file = os.getenv("GITHUB_ENV")
    if status == "success":
        with open(env_file, "a") as fp:
            fp.write("DBT_RUN_ICON=✅\n")
            fp.write(f"DBT_RUN_ID={run_id}\n")
        sys.exit(0)
    else:
        with open(env_file, "a") as fp:
            fp.write("DBT_RUN_ICON=❌\n")
            fp.write(f"DBT_RUN_ID={run_id}\n")
        sys.exit(1)
