import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import classification_report
from ydata_profiling import ProfileReport
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier, RandomForestRegressor,     GradientBoostingRegressor, ExtraTreesRegressor
from sklearn.neural_network import MLPClassifier
from sklearn.metrics import accuracy_score, r2_score, classification_report
from sklearn.pipeline import Pipeline
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import OneHotEncoder

crop_filepath = "./data/new1.csv"
data = pd.read_csv(crop_filepath)

encoder = LabelEncoder()
data.label = encoder.fit_transform(data.label)

features = data.drop("label", axis=1)
target = data.label

rf = RandomForestClassifier(n_estimators=10, max_features=3, random_state=0).fit(features, target)


def rank(field):
    new_data = {
        'N': [field.n],
        'P': [field.p],
        'K': [field.k],
        'temperature': [field.temp],
        'humidity': [field.hum],
        'ph': [field.ph],
        'rainfall': [field.rain],
    }
    X = pd.DataFrame(new_data)
    #rf_pred= rf.predict(X)
    #named_target = encoder.inverse_transform(target)
    rf_prob = rf.predict_proba(X)
    label_probabilities = []
    for i, probabilities in enumerate(rf_prob):
        label_probabilities.append([(probabilities[j], j) for j in range(len(probabilities))])
        label_probabilities[i].sort(reverse=True)

    label_probabilities = label_probabilities[0]
    list_label_probabilities = [list(t) for t in label_probabilities]
    for inner_list in list_label_probabilities:
        inner_list[1] = encoder.inverse_transform([inner_list[1]])
    return list_label_probabilities