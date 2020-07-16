# Clustering 

loc = [] , list of all the lat and long which needs to be plotted


For a particular location iterate through all the other locations in the list and remove the locations which are less that 100 metres from the current location but before removing
compute the average index for all these locations and change the index of the current location to newly calculated index.

Time Complexity - O(n^2)
