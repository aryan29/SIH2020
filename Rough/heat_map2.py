# Heat Map Based on All these factors
# Amt of Garbage-0.35
# Extent of Non Biodegradability-0.2
# Number of Animals-0.1
# Number of Water Bodies-0.1
# Population Density-0.25
# In a Particular Area
import gmplot
import requests

latitude_list = [30.3358376, 31.3358376, 31.3358376, 30.3358376]
longitude_list = [77.8701919, 77.8701919, 78.0413095, 78.0413095]

gmap5 = gmplot.GoogleMapPlotter(30.3164945,
                                78.03219179999999, 13, "AIzaSyBjY9QF01OsfFXH83XyV9F5sZQRZGgQ1sQ")

gmap5.scatter(latitude_list, longitude_list, '# FF0000',
              size=40, marker=False)
gmap5.polygon(latitude_list, longitude_list,
              color='cornflowerblue')
gmap5.draw("file2.html")
# Similarly we can request rivers and oceans in a ciruclar area and mark it
r = requests.get(
    "https://maps.googleapis.com/maps/api/place/textsearch/json?query=lake&key=AIzaSyBjY9QF01OsfFXH83XyV9F5sZQRZGgQ1sQ&location=30.8658376,77.9701919&radius=1000")
print(r.text)
