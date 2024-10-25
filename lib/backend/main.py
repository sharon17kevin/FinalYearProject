import sys
import os
import json
from pydash import from_pairs
from rule_base import construct_rotation_step
from rank import rank
from simulate import genField
from utilities import change_rank, compile_score

current_dir = os.path.dirname(os.path.abspath(__file__))

sys.path.insert(0, os.path.join(current_dir, 'models'))

from field import Field

# Open the JSON file and load its contents
with open('crop.json', 'r') as f:
    data = json.load(f)

crops = list(data.keys())

cropDict = from_pairs([(crop, 0) for crop in crops])

#step = construct_rotation_step(cropDict, field.crop)
#step = sorted(step.items(), key= lambda x: x[1], reverse=True)

#r = rank(field)
#new = change_rank(r)
#step = compile_score(new, step)
#step = sorted(step.items(), key= lambda x: x[1], reverse=True)
#print(step)