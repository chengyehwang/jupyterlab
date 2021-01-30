# import kivy module 
import kivy 
  
# this restrict the kivy version i.e 
# below this kivy version you cannot 
# use the app or software 
#kivy.require("1.9.1") 
  
# base Class of your App inherits from the App class. 
# app:always refers to the instance of your application 
from kivy.app import App 
  
# creates the button in kivy 
# if not imported shows the error 
from kivy.uix.button import Button 

# jupyter server
import sys
from jupyter_core.command import main as jupyter_main

# class in which we are creating the button 
class ButtonApp(App): 
      
    def build(self): 
          
        btn = Button(text ="Run Jupyter")
        btn.bind(on_press=self.callback)
        return btn

    def callback(self, event):
        print("Jupyter server is running")
        sys.argv = ['jupyter', 'notebook']
        jupyter_main()
  
# creating the object root for ButtonApp() class  
root = ButtonApp() 
  
# run function runs the whole program 
# i.e run() method which calls the 
# target function passed to the constructor. 
root.run() 

