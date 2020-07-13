import requests
import json


def get_list(lat, lon):
    url = f"https://maps.googleapis.com/maps/api/place/textsearch/json?query=NGO&key=AIzaSyDAaGzlR9XHDGvdBHn2ZpHl7RU_tWMgil0&location={lat},{lon}&radius=100&region=in"
    res = requests.get(url)
    stri = json.loads(res.text)
    namelist = []
    addlist = []
    gmap_rating = []
    icons = []
    for i in stri['results']:
        namelist.append(i['name'])
        addlist.append(i['formatted_address'])
        gmap_rating.append(i['rating'])
        icons.append(i['icon'])

    # print(namelist)
    # print(addlist)
    # print(gmap_rating)
    print(icons)

    return {"name": namelist, "address": addlist, "rating": gmap_rating, "icons": icons}
