from flask_cors import CORS
from flask import Flask, request, jsonify
import json
import os
import sys
import pydash

current_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(current_dir, '../'))
sys.path.insert(0, os.path.join(current_dir, '../models'))

from simulate import genField
from rule_base import decode_steps, crop_plan_next, reset_score, decode_steps_initial, crop_plan_initial
from main import cropDict
from field import Field
data = cropDict

app = Flask(__name__)
CORS(app)
'''
@app.after_request_funcs
def add_cors_header(response):
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST,GET,OPTIONS,PUT,DELETE,HEAD'
    return response
'''

@app.route('/field', methods = ['GET'])
def getFieldInfo():
    field = genField()
    return jsonify(field.__dict__)

@app.route('/field/update', methods =['POST'])
def getUpdatedFieldInfo():
    response =request.get_json()
    newField = genField()
    field = Field(
        n = newField.n,
        p = newField.p,
        k =  newField.k,
        temp =  newField.temp,
        hum =  newField.hum,
        rain =  newField.rain,
        ph = newField.ph,
        crops = response['crops'],
        history = response['history']
    )
    return jsonify(field)

@app.route('/plan', methods =['POST'])
def getRotationPlan():
    response =request.get_json()
    field = Field(
        n = response['n'],
        p = response['p'],
        k =  response['k'],
        temp =  response['temp'],
        hum =  response['hum'],
        rain =  response['rain'],
        ph = response['ph'],
        crops = response['crops'],
        history = response['history']
    )
    #cropDict = reset_score(data)
    new_field = decode_steps_initial(cropDict, field)
    return jsonify(new_field)

@app.route('/analysis', methods =['POST'])
def getRotationAnalysis():
    response =request.get_json()
    field = Field(
        n = response['n'],
        p = response['p'],
        k =  response['k'],
        temp =  response['temp'],
        hum =  response['hum'],
        rain =  response['rain'],
        ph = response['ph'],
        crops = response['crops'],
        history = response['history']
    )
    cropDict = reset_score(data)
    step = crop_plan_next(cropDict, field)
    return jsonify(step)

@app.route('/analysis/initial', methods =['POST'])
def getInitialAnalysis():
    response =request.get_json()
    field = Field(
        n = response['n'],
        p = response['p'],
        k =  response['k'],
        temp =  response['temp'],
        hum =  response['hum'],
        rain =  response['rain'],
        ph = response['ph'],
        crops = response['crops'],
        history = response['history']
    )
    cropDict = reset_score(data)
    step = crop_plan_initial(cropDict, field)
    return jsonify(step)

@app.route('/update', methods =['POST'])
def getStepPlan():
    response = request.get_json()
    field = Field(
        n = response['field']['n'],
        p = response['field']['p'],
        k =  response['field']['k'],
        temp =  response['field']['temp'],
        hum =  response['field']['hum'],
        rain =  response['field']['rain'],
        ph = response['field']['ph'],
        crops = response['field']['crops']
    )
    index = response['index']
    rotation_plan = field.crops
    first_half = rotation_plan[:index + 1]
    field.crop = first_half
    cropDict = reset_score(data)
    step = crop_plan_next(cropDict, field)
    first_item = step[:1]
    first_value = list(map(lambda x: x[0], first_item))
    rotation_plan[index] = first_value[0]
    field.crops = rotation_plan
    return jsonify(field)




if __name__ =="__main__":
    app.run()