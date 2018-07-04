import librosa
from hmmlearn.hmm import GaussianHMM
import numpy as np
import os
from random import shuffle
from sklearn.metrics import accuracy_score
from math import floor
import operator
import warnings
from sklearn.externals import joblib
warnings.filterwarnings("ignore")
live = False
class Word:
    def __init__(self, file, label, features):
        self.file = file
        self.label = label
        self.features = features
    def __repr__(self):
        return '(word: {})'.format(self.label)
class Model:
    n_mfcc = 20
    p_train = 1 if live else 0.7
    states = 10
    def __init__(self, label):
        self.label = label
        self.train_data = np.zeros((0, Model.n_mfcc))
        self.clf = GaussianHMM(Model.states)
def extract_features():
    words = {}
    audio_folder = 'audio'
    for label in os.listdir(audio_folder):
        words[label] = []
        label_folder = audio_folder + '/' + label
        for file in os.listdir(label_folder):
            file = label_folder + '/' + file
            data, rate = librosa.load(file, None)
            data, cut_indices = librosa.effects.trim(data, top_db=30)
            features = librosa.feature.mfcc(data, rate, n_mfcc=Model.n_mfcc)
            features = features.T  # transpose matrix
            word = Word(file, label, features)
            words[label].append(word)
    print('imported words:', [*words])
    return words
def test_train_split(words, p_train):
    train_words = {}
    test_words = []
    for label in words:
        label_words = words[label]
        n_words = len(label_words)
        n_train = floor(n_words * p_train)
        shuffle(label_words)  # randomize to prevent same words being used for testing every time
        train_words[label] = label_words[:n_train]
        test_words.extend(label_words[n_train:])
    return train_words, test_words
def fit_models(train_words):
    models = []
    for label in train_words:
        model = Model(label)
        for word in train_words[label]:
            model.train_data = np.concatenate((model.train_data, word.features))
        model.clf.fit(model.train_data)
        model_file = 'models/{}.pkl'.format(model.label)
        joblib.dump(model.clf, model_file)
        models.append(model)
    return models
def test(models, test_words):
    results = []
    for word in test_words:
        word_scores = {}
        for model in models:
            model_score = model.clf.score(word.features)
            word_scores[model.label] = model_score
        best_label = max(word_scores.items(), key=operator.itemgetter(1))[0]
        results.append(best_label)
    return results
def display_results(test_words, results):
    true_labels = []
    for i in range(len(test_words)):
        true_labels.append(test_words[i].label)
        true_label = test_words[i].label
        pred_label = results[i]
        file = test_words[i].file
        output = '{:9} | {:9} | {:30}'.format(true_label, pred_label, file)
        print(output, end='\n' + '-' * 54 + '\n')
    accuracy = accuracy_score(true_labels, results)
    print('accuracy:', accuracy)
def main():
    words = extract_features()
    if not live:
        words, test_words = test_train_split(words, Model.p_train)
    models = fit_models(words)
    if not live:
        results = test(models, test_words)
        display_results(test_words, results)
if __name__ == '__main__':
    main()