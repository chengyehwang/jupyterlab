# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.4.2
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

from IPython.display import clear_output
from appium import webdriver
from appium.webdriver.common.touch_action import TouchAction
from IPython.display import Image
import imageio
from datetime import datetime
now = datetime.now()
now = now.strftime("%Y-%m-%d-%H-%M")
display(now)
writer = imageio.get_writer('pubg%s.mp4'%now, fps=2)


def connect():
    global driver
    desired_caps = {}
    desired_caps['platformName'] = 'Android'
    desired_caps['automationName'] = 'uiautomator2'
    desired_caps['deviceName'] = 'pixel 4'
    driver = webdriver.Remote('http://192.168.0.230:4723/wd/hub', desired_caps)


# +
def move(base, to):
    action = TouchAction(driver)
    action.press(**base)
    action.move_to(**to)
    action.wait(10)
    action.release()
    action.perform()

def forward():
    move({'x':251, 'y':600},{'x':251, 'y':400})
def left():
    move({'x':551, 'y':600},{'x':251, 'y':100})
def right():
    move({'x':551, 'y':600},{'x':851, 'y':400})
def image(i):
    driver.get_screenshot_as_file('test%d.png'%i)
    im = imageio.imread('test%d.png'%i)
    writer.append_data(im)
    display(Image(filename='test%d.png'%i))
def close():
    writer.close()
# -



connect()
while True:
    try:
        for i in range(20):
            forward()
            left()
            right()
            image(i)
        clear_output()
    except Exception as e:
        print(e)
        connect()



# # 
