import sys

import requests
from pprint import pprint

URL = "https://lua-dbt-services-backend-msgn5tdnsa-uc.a.run.app/api/v1/projects/0684933f5c3247a2ba73e9e687474957/sync"

if __name__ == "__main__":
    res = requests.get(url=URL)
    pprint(res.json())
    assert res.status_code == 200
    sys.exit(0)
