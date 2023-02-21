import csv
import os
import requests

path = os.getcwd()
TYPE = "real"   # "real" or "fake"

with open("df_" + TYPE + ".csv") as csvfile:
    csvrows = csv.reader(csvfile, delimiter=',', quotechar='"')
    for row in csvrows:
        filename = ("images_" + TYPE + "/" + row[0] + ".png")
        url = row[1].replace(" ", "+")
        print(url)
        result = requests.get(url, stream=True)
        if result.status_code == 200:
            image = result.raw.read()
            open(filename, "wb").write(image)
