import requests
import json
from math import radians, sin, cos, acos
import time


def normalize(inp):
    if min(inp) == max(inp):

        for i in range(0, len(inp)):
            inp[i] = inp[i]/min(inp)
    else:

        for i in range(0, len(inp)):
            inp[i] = inp[i] - min(inp)
            inp[i] = inp[i]/(max(inp) - min(inp))

    return inp


def compute_distance(x, y, u, v):

    slat = radians(float(x))
    slon = radians(float(y))
    elat = radians(float(u))
    elon = radians(float(v))

    dist = 1000 * 6371.01 * \
        acos(sin(slat)*sin(elat) + cos(slat)*cos(elat)*cos(slon - elon))
    return dist


def get_water_bodies(x, y):
    water_cnt = 0
    loc = str(x)+','+str(y)
    # &rankby=distance')
    river = requests.post(
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=river&key=AIzaSyDAaGzlR9XHDGvdBHn2ZpHl7RU_tWMgil0&radius=100&sensor=false&location='+loc)
    # &rankby=distance')
    lake = requests.post(
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=lake&key=AIzaSyDAaGzlR9XHDGvdBHn2ZpHl7RU_tWMgil0&radius=100&sensor=false&location='+loc)
    river = river.json()
    lake = lake.json()

    for element in river['results']:

        geo = element['geometry']
        a = geo['location']['lat']
        b = geo['location']['lng']
        d = compute_distance(x, y, a, b)
        if d <= float(10000):
            water_cnt += 1

    for element in lake['results']:

        geo = element['geometry']
        a = geo['location']['lat']
        b = geo['location']['lng']
        d = compute_distance(x, y, a, b)
        if d <= float(10000):
            water_cnt += 1
    time.sleep(1)
    return water_cnt


def get_pop_density(x, y):
    loc = str(x)+','+str(y)
    res = requests.post('https://maps.googleapis.com/maps/api/geocode/json?latlng=' +
                        loc+'&key=AIzaSyDAaGzlR9XHDGvdBHn2ZpHl7RU_tWMgil0')
    res = (res.json())
    try:
        temp = res['results'][3]
        city = temp['address_components'][0]['long_name']
    except:
        return 1000
    # print(city)

    tmp = 'https://public.opendatasoft.com/api/records/1.0/search/?dataset=worldcitiespop&q=%s&sort=population&facet=country&refine.country=%s'
    cmd = tmp % (city, 'in')
    res = requests.get(cmd)
    dct = json.loads(res.content)
    try:
        out = dct['records'][0]['fields']
        ans = out['population']
    except:
        ans = 10000
    time.sleep(1)
    # print(ans)
    return ans


def GetUnAssignedIndexes():
    di = {
        "password": "letitbeanything"
    }
    x = requests.post(
        "/api/admin/getActiveImagesData", data=di)
    data = x.json()
    print(data)
    #data = json.dumps(x.json())
    latitude = []
    longitude = []
    animals = []
    pks = []

    for element in data:
        latitude.append(element['latitude'])
        longitude.append(element['longitude'])
        animals.append(element['animals'])
        pks.append(element['pk'])

    #print(latitude, longitude, animals)

    final_latitude = []
    final_longitude = []
    final_animals = []
    locations = []
    water_body = []
    final_pks = []
    final_index = []
    pop_den = []

    while len(latitude) != 0:
        p = latitude[0]
        q = longitude[0]
        a = animals[0]
        loc = 1
        temp = [pks[0]]

        latitude.remove(latitude[0])
        longitude.remove(longitude[0])
        animals.remove(animals[0])
        pks.remove(pks[0])

        cnt = len(latitude)
        j = 0

        while cnt != 0:

            u = latitude[j]
            v = longitude[j]
            dist = compute_distance(p, q, u, v)

            if dist <= float(10000):

                a += animals[j]
                loc += 1
                temp.append(pks[j])
                latitude.remove(latitude[j])
                longitude.remove(longitude[j])
                animals.remove(animals[j])
                pks.remove(pks[j])

            else:
                j += 1
            cnt -= 1

        final_latitude.append(p)
        final_longitude.append(q)
        final_animals.append(a)
        final_pks.append(temp)
        locations.append(loc)
        # print("here")

    for i in range(0, len(final_latitude)):

        water_cnt = get_water_bodies(final_latitude[i], final_longitude[i])
        water_body.append(water_cnt)
        pop = get_pop_density(final_latitude[i], final_longitude[i])
        pop_den.append(pop)

    [float(i) for i in locations]
    [float(i) for i in water_body]
    [float(i) for i in final_animals]
    [float(i) for i in pop_den]

    locations = normalize(locations)
    water_body = normalize(water_body)
    final_animals = normalize(final_animals)
    pop_den = normalize(pop_den)

    for i in range(len(final_latitude)):
        final_index.append(int(
            (locations[i]*35) + (final_animals[i]*15) + (pop_den[i]*25) + (water_body[i]*25)))

    print(final_latitude)
    print(final_longitude)
    print(final_animals)
    print(locations)
    print(water_body)
    print(pop_den)
    print(final_index)
    print(final_pks)

    return final_latitude, final_longitude, final_index, final_pks
