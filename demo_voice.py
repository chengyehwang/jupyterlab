# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.10.1
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

import speech_recognition as sr

import os
if not os.path.exists('harvard.wav'):
    os.system('wget https://github.com/realpython/python-speech-recognition/raw/master/audio_files/harvard.wav')

r = sr.Recognizer()

with sr.WavFile("harvard.wav") as source:
    audio = r.record(source)

audio

r.recognize_sphinx(audio)


