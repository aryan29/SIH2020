import json
import requests
di = {
    "password": "letitbeanything"
}
f = requests.post("http://127.0.0.1:8000/api/admin/getPlottingData", data=di)
print(f.json())
json_string = json.dumps(f.json())
print(json_string)
