# Heat Map Purely Based on Garbage Intensity Based on Single Point Locations
import gmplot
import numpy as np
latitude1 = (np.random.random_sample(size=700) - 0) * 50
longitude1 = (np.random.random_sample(size=700) - 0) * 100
gm = gmplot.GoogleMapPlotter(
    20, 78, 8, "AIzaSyBjY9QF01OsfFXH83XyV9F5sZQRZGgQ1sQ")
gm.heatmap(latitude1, longitude1, radius=20,
           gradient=[(0, 128, 0, 0.9), (255, 255, 0, 1), (255, 0, 0, 1)])
gm.draw("file.html")
