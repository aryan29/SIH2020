import requests
# data = {
#     "username": "aryan",
#     "password": "29062000"
# }
# r = requests.post("http://localhost:8000/api-token-auth/", data=data)
# print(r.text)

# Now use this authorization token to get access to your web app
# headers = {
#     "Authorization": "Token 95c513886593bf9b913c0339aa3a924cdb72fd44"
# }
# r = requests.get("http://localhost:8000/api/users/", headers=headers)
# print(r.text)
data={
    "username":"brodaApi",
    "password1":"Aryan@2000",
    "password2":"Aryan@2000",
    "email":"nk28agra@gmail.com",
    "mob":"+917906224093",
    "address":"47,Vaibhav Residency,Karmyogi,Kamla Nagar,Agra",
    "choice":"AppUsers"
}


r=requests.post("http://localhost:8000/register/",data=data)
print(r.text)
