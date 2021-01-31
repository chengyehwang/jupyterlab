from kivy.app import App
from kivy.lang import Builder
from kivy.uix.screenmanager import ScreenManager, Screen

Builder.load_string("""
<TopScreen>:
    BoxLayout:
        orientation:'vertical'
        Button:
            text: 'Go Education'
            on_press: root.manager.current = 'Education'
        Button:
            text: 'Go Engineering'
            on_press: root.manager.current = 'Engineering'
        Button:
            text: 'Go Science'
            on_press: root.manager.current = 'Science'
        Button:
            text: 'Go Develop'
            on_press: root.manager.current = 'Develop'
<EducationScreen>:
    BoxLayout:
        orientation:'vertical'
        Label:
            text: 'Test: Under Construction'
        TextInput:
        Button:
            text: 'Back to Top'
            on_press: root.manager.current = 'Top'
<EngineeringScreen>:
    BoxLayout:
        orientation:'vertical'
        Label:
            text: 'Under Construction'
        Button:
            text: 'Back to Top'
            on_press: root.manager.current = 'Top'
<ScienceScreen>:
    BoxLayout:
        orientation:'vertical'
        Label:
            text: 'Under Construction'
        Button:
            text: 'Back to Top'
            on_press: root.manager.current = 'Top'
<DevelopScreen>:
    BoxLayout:
        orientation:'vertical'
        Label:
            text: 'Python Interpreter'
        TextInput:
            id: input
        Button:
            text: 'Run'
            on_press: root.run()
        TextInput:
            id: output
            text: ''
        Button:
            text: 'Back to Top'
            on_press: root.manager.current = 'Top'
""")

class TopScreen(Screen):
    pass
class EducationScreen(Screen):
    pass
class EngineeringScreen(Screen):
    pass
class ScienceScreen(Screen):
    pass

import sys
from io import StringIO
import contextlib

@contextlib.contextmanager
def stdoutIO(stdout=None):
    old = sys.stdout
    if stdout is None:
        stdout = StringIO()
    sys.stdout = stdout
    yield stdout
    sys.stdout = old

class DevelopScreen(Screen):
    def run(self):
        input = self.ids.input.text
        print('============== input  ===========')
        print(input)
        with stdoutIO() as s:
            try:
                exec(input)
            except:
                print('error in code')
        output = s.getvalue()
        print('============== output ===========')
        print(output)
        self.ids.output.text = output
    pass

class myApp(App):
    def build(self):
        sm = ScreenManager()
        sm.add_widget(TopScreen(name='Top'))
        sm.add_widget(EducationScreen(name='Education'))
        sm.add_widget(EngineeringScreen(name='Engineering'))
        sm.add_widget(ScienceScreen(name='Science'))
        sm.add_widget(DevelopScreen(name='Develop'))
        
        return sm

if __name__ == '__main__':
    myApp().run()
