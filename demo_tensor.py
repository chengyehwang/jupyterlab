import tensorflow as tf
import tflite_runtime.interpreter as tflite
from tflite_runtime.interpreter import Interpreter

# curl https://dl.google.com/coral/canned_models/mobilenet_v1_1.0_224_quant_edgetpu.tflite --output mobilenet.tflite

model = 'mobilenet.tflite'

interpreter = Interpreter(model)


