import requests
di = {
    "password": "letitbeanything"
}
x = requests.post("http://0.0.0.0:8000/api/admin/getActiveImagesData", data=di)

