import requests
# data = {
#     "username": "aryan",
#     "password": "29062000"
# }
# r = requests.post("http://localhost:8000/api-token-auth/", data=data)
# print(r.text)

# Now use this authorization token to get access to your web app
headers = {
    "Authorization": "Token 95c513886593bf9b913c0339aa3a924cdb72fd44"
}
r = requests.get("http://localhost:8000/api/users/", headers=headers)
print(r.text)
