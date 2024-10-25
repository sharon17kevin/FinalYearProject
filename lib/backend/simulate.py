import random
import sys
import os
import json

with open('crop.json', 'r') as f:
    data = json.load(f)

crops1 = list(data.keys())

current_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(current_dir, 'models'))

from field import Field

def genField():
    field = Field(
        n=random.randint(0, 201),
        p=random.randint(0, 201),
        k=random.randint(0, 300),
        temp=random.uniform(8, 50),
        hum=random.uniform(13, 110),
        ph=random.uniform(3, 10),
        rain=random.uniform(19, 220),
        #crops=random.sample(crops1, 3))
        crops=[])

    return field
