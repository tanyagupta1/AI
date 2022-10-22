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
        if(u==v):
            city1 = geolocator.geocode(u)
            city2 = geolocator.geocode(v)
            kolkata = (city1.latitude,city1.longitude)
            delhi = (city2.latitude,city2.longitude)
            fact = "h_n('"+u+"','"+v+"',"+str(great_circle(kolkata, delhi).km)+").\n"
            print(fact)
            # file2.write(fact)
            # print(u,' ',v,' ',great_circle(kolkata, delhi).km)

    