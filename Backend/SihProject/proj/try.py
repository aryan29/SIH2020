import requests
di = {
    "password": "letitbeanything"
}
x = requests.post("http://0.0.0.0:8000/api/admin/getPlottingData", data=di)
print(type(x))
print(x.text)
