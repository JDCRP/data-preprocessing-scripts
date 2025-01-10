import pandas as pd 
import requests
import json
import csv


url = 'http://api.geonames.org/searchJSON?'

#Change df parameters according to excel sheet specification.

df = pd.read_excel('geonames-test-data-subset.xlsx')

for item in df.place_name:

    df.place_name.head()
    df.country_name.head()
    #Change username params with geonames API username

    params = {  'username': "jonathanblok", 
                #'name_equals': item,
                'name': item,
                'country': df.country_name,
                'maxRows': "1"}

    e = requests.get(url, params = params)

    pretty_json = json.loads(e.text)

    with open("data14.txt", "a") as myfile:

            writer = csv.writer(myfile)

            if len(pretty_json) > 2:
                for item in pretty_json["geonames"]:
                        writer.writerow([item["name"], "https://www.geonames.org/{}".format(item["geonameId"])])  #Write row.
            else:
                print(pretty_json)

    myfile.close()
