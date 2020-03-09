import gmplot
import numpy as np
# latitude = (np.random.random_sample(size=700) - 1) * 50
# longitude = (np.random.random_sample(size=700) - 1) * 100
latitude1 = (np.random.random_sample(size=700) - 0) * 50
longitude1 = (np.random.random_sample(size=700) - 0) * 100
# print(longitude)
gm = gmplot.GoogleMapPlotter(
    20, 78, 8, "AIzaSyBjY9QF01OsfFXH83XyV9F5sZQRZGgQ1sQ")
# gm.heatmap(latitude, longitude, radius=30)
gm.heatmap(latitude1, longitude1, radius=20,
           gradient=[(0, 128, 0, 0.1), (255, 255, 0, 1), (255, 0, 0, 1)])
gm.draw("file.html")
# print(gmplot.GoogleMapPlotter.from_geocode("Dehradun,India"))
