import requests
import json


def get_list(lat, lon):
    url = f"https://maps.googleapis.com/maps/api/place/textsearch/json?query=NGO&key=AIzaSyAikOGBw3sNCCKTQK_MP11RtLx6uTQVur8&location={lat},{lon}&radius=100&region=in"
    res = requests.get(url)
    stri = json.loads(res.text)
    mylist = []
    for i in stri['results']:
        mylist.append(i['name'])
    return mylist
