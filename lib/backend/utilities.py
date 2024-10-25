import pydash
from pydash import map_, set_, get


def sort_dict(my_dict):
    sorted_dict = pydash.from_pairs(sorted(pydash.to_pairs(my_dict), key=lambda x: x[1]))
    return sorted_dict

def change_rank(r):
    rank = [x[1][0] for x in r]
    second = [x[0] for x in r]
    new = list(zip(rank, second))
    return new

def compile_score(rank, step):
    new_rank = {key: value for key, value in rank}
    new_step = {key: value for key, value in step}
    for k,v in new_step.items():
        score = v + new_rank[k]*20
        set_(new_step, k, score)
    return new_step
