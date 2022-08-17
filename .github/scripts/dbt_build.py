import os
import sys
import requests
from pprint import pprint


if __name__ == "__main__":
    target = os.getenv("TARGET", "dev")
    url = "https://lua-dbt-services-msgn5tdnsa-uc.a.run.app/dbt"
    data = dict(command="build", target=target)
    res = requests.post(url=url, json=data)
    data = res.json()
    status = data.get("status", "error")
    pprint(data)
    if status == "success":
        sys.exit(0)
    sys.exit(1)
