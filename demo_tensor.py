from tensorflow.lite.python.interpreter import Interpreter, load_delegate

# curl https://dl.google.com/coral/canned_models/mobilenet_v1_1.0_224_quant_edgetpu.tflite --output mobilenet.tflite
# wget https://github.com/chengyehwang/termux_bootstrap/raw/main/libtensorflowlite_gpu_delegate.so

model = 'mobilenet.tflite'

interpreter = Interpreter(model)
interpreter = Interpreter(model,
        experimental_delegates=[load_delegate('./libtensorflowlite_gpu_delegate.so')])

