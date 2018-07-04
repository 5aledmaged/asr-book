import pyaudio
import wave
import os
from sklearn.externals import joblib
import librosa
import operator
import warnings
import soundfile as sf
import numpy as np
warnings.filterwarnings('ignore')
def record_audio():
    chunk = 1024
    sample_format = pyaudio.paInt16
    channels = 1
    rate = 44100
    record_seconds = 2
    output_filename = 'output.wav'
    p = pyaudio.PyAudio()
    stream = p.open(format=sample_format,
                    channels=channels,
                    rate=rate,
                    input=True,
                    frames_per_buffer=chunk)
    print('* recording')
    frames = []
    for i in range(0, int(rate / chunk * record_seconds)):
        data = stream.read(chunk)
        frames.append(data)
    print('* done recording')
    stream.stop_stream()
    stream.close()
    p.terminate()
    wf = wave.open(output_filename, 'wb')
    wf.setnchannels(channels)
    wf.setsampwidth(p.get_sample_size(sample_format))
    wf.setframerate(rate)
    wf.writeframes(b''.join(frames))
    wf.close()
    data, rate = librosa.load('output.wav', None)
    data, cut_indices = librosa.effects.trim(data, top_db=30)
    librosa.output.write_wav('output2.wav', data, rate)
    sf.write('output3.wav', data, rate, 'PCM_16')
def load_models():
    models = {}
    models_dir = 'models'
    for model_label in os.listdir(models_dir):
        file = models_dir + '/' + model_label
        model = joblib.load(file)
        model_label = model_label.replace('.pkl', '')
        models[model_label] = model
    return models
def classify_word(models):
    file = 'output3.wav'
    data, rate = librosa.load(file, None)
    features = librosa.feature.mfcc(data, rate, n_mfcc=20)
    features = features.T
    scores = {}
    for model_label, model in models.items():
        model_score = model.score(features)
        scores[model_label] = model_score
    best_label = max(scores.items(), key=operator.itemgetter(1))[0]
    print(best_label)
def main():
    record_audio()
    models = load_models()
    classify_word(models)
if __name__ == '__main__':
    main()