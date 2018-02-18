from flask import Flask, jsonify, request, Response
import requests, random, string, json
from utils.db import readdb, writedb

app = Flask(__name__)
app.secret_key = "SECRET-KEY"

@app.route('/<riddle_id>', methods=['GET', 'POST'])
def get_riddle(riddle_id):
    title = readdb(riddle_id).get('title')
    riddle_creator = readdb(riddle_id).get('creatorUsername')
    points = readdb(riddle_id).get('points')
    length = readdb(riddle_id).get('length')
    geofence = readdb(riddle_id).get('geofence')
    question = readdb(riddle_id).get('question')

    total_lon = 0
    total_lat = 0
    for i in range(len(geofence)):
        temp_point = geofence[i]
        total_lat += float(temp_point['lat'])
        total_lon += float(temp_point['lon'])

    center_lon = total_lon/len(geofence)
    center_lat = total_lat/len(geofence)



    if request.method == 'POST':
        return jsonify(title=title, creator=riddle_creator, length=length,
                       points=points, geofence=geofence, riddle=question,
                       center_lat=center_lat, center_lon=center_lon)

    return jsonify(title=title, creator=riddle_creator, length=length,
                   points=points, geofence=geofence, center_lat=center_lat,
                   center_lon=center_lon)
@app.route('/search')
def search():
    json_array = []
    file_array = ['HopHacks','qGjUaBuw']
    for i in range(len(file_array)):
        json_array.append(readdb(file_array[i]))
    return jsonify(results=json_array)

@app.route('/submit', methods=['GET','POST'])
def submit():
    valid = False
    if request.method == 'POST':
        answer_json_data = json.load(request.body)
        lon = answer_json_data['longitude']
        lat = answer_json_data['latitude']
        guess = answer_json_data['answer']
        riddle_id = answer_json_data['riddle_id']

        answer_lat = readdb(riddle_id).get('latitude')
        answer_lon = readdb(riddle_id).get('longitude')
        answer_text = readdb(riddle_id).get('answer')

        if guess == answer_text or (lat == answer_lat and lon == answer_lon):
            valid = True

    return jsonify(correct=valid)


@app.route('/create/<title1>/<length1>/<question1>/<longitude1>/<latitude1>/<answer1>/<geofence1>', methods=['GET'])
def create(title1, length1, creator1, question1, longitude1, latitude1, geofence1):
    if request.method == 'GET':
        title = title1
        length = length1
        question = question1
        longitude = longitude1
        latitude = latitude1
        geofence = geofence1
        answer = answer1
        points = '10'




        chars = string.ascii_letters + string.digits
        pwdSize = 8
        riddle_id = ''
        for x in range(pwdSize):
            riddle_id += random.choice(chars)

        file_location = 'db/'+riddle_id+'.json'

        open(file_location, 'w+')

        data = {
            "title":title,
            "length":length,
            "creatorUsername":'HopHacks',
            "points":points,
            "question":question,
            "longitude":longitude,
            "latitude":latitude,
            "answer":answer,
            "geofence":geofence
        }

        jsonData = json.dumps(data)

        with open(file_location, 'w') as f:
             json.dump(data, f)

        return jsonData


if __name__ == '__main__':
    app.debug = True
    app.run()
