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
            text: 'Under Construction'
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
            text: 'Under Construction'
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
class DevelopScreen(Screen):
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
