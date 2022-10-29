# Import the required library
from geopy.geocoders import Nominatim
from geopy.distance import great_circle
import csv

geolocator = Nominatim(user_agent="MyApp")

cities = set()

file = open('roaddistance.csv')
file2 = open('heuristics.pl','w')
csvreader = csv.reader(file)
header = []
header = next(csvreader)
for h in header:
    cities.add(h)

for row in csvreader:
    cities.add(row[0])


for u in cities:
    for v in cities:
        city1 = geolocator.geocode(u)
        city2 = geolocator.geocode(v)
        coordinates_1 = (city1.latitude,city1.longitude)
        coordinates_2 = (city2.latitude,city2.longitude)
        fact = "h_n('"+u+"','"+v+"',"+str(great_circle(coordinates_1,coordinates_2).km)+").\n"
        print(fact)
        file2.write(fact)

    