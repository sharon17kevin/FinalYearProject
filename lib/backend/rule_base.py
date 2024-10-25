import json
from pydash import map_, set_, get
import pydash
import utilities
from rank import rank
from simulate import genField
# Open the JSON file and load its contents
with open('crop.json', 'r') as f:
    data = json.load(f)

def check_family_history(cropDict, fieldHistory):
    fieldHist = fieldHistory[-3:]
    fieldHistFam = map_(fieldHist, lambda x: get(data, f'{x}.family'))
    for k,v in cropDict.items():
        if get(data, f'{k}.family') in fieldHistFam:
            score = v - 12
            set_(cropDict, k, score)
        else:
            score = v + 7
            set_(cropDict, k, score)
    return cropDict

def check_root_history(cropDict, fieldHistory):
    fieldHist = fieldHistory[-3:]
    fieldHistRoot = map_(fieldHist, lambda x: get(data, f'{x}.root'))
    for k,v in cropDict.items():
        if get(data, f'{k}.root') in fieldHistRoot:
            score = v - 12
            set_(cropDict, k, score)
        else:
            score = v + 7
            set_(cropDict, k, score)
    return cropDict

def legume_check(cropDict, fieldHistory):
    fieldHist = fieldHistory[-3:]
    fieldHistLegume = map_(fieldHist, lambda x: get(data, f'{x}.family'))
    if "legume" not in fieldHistLegume:
        for k,v in cropDict.items():
            if (get(data, f'{k}.family') != "legume"):
                score = v - 12
                set_(cropDict, k, score)
            else:
                score = v + 7 
                set_(cropDict, k, score)
    return cropDict

def reset_score(cropDict):
    for k,v in cropDict.items():
        v = 0
        set_(cropDict, k, v)
    return  cropDict

def check_crop_type(cropDict, fieldHistory):
    fieldHist = fieldHistory[-3:]
    fieldHistType = map_(fieldHist, lambda x: get(data, f'{x}.type'))
    if "cover crop" not  in fieldHistType:
        for k,v in cropDict.items():
            if (get(data, f'{k}.type') != "cover crop"):
                score = v - 12
                set_(cropDict, k, score)
            else:
                score = v + 7
                set_(cropDict, k, score)
    return cropDict

def construct_rotation_step(cropDict, fieldHistory):
    cropDict = reset_score(cropDict)
    cropDict = check_family_history(cropDict, fieldHistory)
    cropDict = check_root_history(cropDict, fieldHistory)
    cropDict = check_crop_type(cropDict, fieldHistory)
    cropDict = legume_check(cropDict, fieldHistory)
    return cropDict

def crop_plan_next(cropDict, field):
    step = construct_rotation_step(cropDict, field.crops)
    step = sorted(step.items(), key= lambda x: x[1], reverse=True)
    r = rank(field)
    new = utilities.change_rank(r)
    step = utilities.compile_score(new, step)
    step = sorted(step.items(), key= lambda x: x[1], reverse=True)
    return step

def crop_plan_initial(cropDict, field):
    step = construct_rotation_step(cropDict, field.history)
    step = sorted(step.items(), key= lambda x: x[1], reverse=True)
    r = rank(field)
    new = utilities.change_rank(r)
    step = utilities.compile_score(new, step)
    step = sorted(step.items(), key= lambda x: x[1], reverse=True)
    return step

def decode_steps(cropDict, field):
    rotation_plan = []
    for i in range(5):
        cropDict = reset_score(cropDict)
        step = crop_plan_next(cropDict, field)
        first_item = step[0]
        first_value = first_item[0]
        rotation_plan.append(first_value)
        field = genField()
    field.crops.extend(rotation_plan)
    return field

def decode_steps_initial(cropDict, field):
    rotation_plan = []
    cropDict = reset_score(cropDict)
    step = crop_plan_initial(cropDict, field)
    new = step[:1]
    rotation_plan = list(map(lambda x: x[0], new))
    field.crops.append(rotation_plan[0])
    field.history.append(rotation_plan[0])
    return {
        'field' : field,
        'step' : step,
    }