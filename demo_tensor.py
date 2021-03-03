from tensorflow.lite.python.interpreter import Interpreter

# curl https://dl.google.com/coral/canned_models/mobilenet_v1_1.0_224_quant_edgetpu.tflite --output mobilenet.tflite

model = 'mobilenet.tflite'

interpreter = Interpreter(model)


