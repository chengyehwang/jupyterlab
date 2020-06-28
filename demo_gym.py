import gym
from gym import spaces
from gym.utils import colorize, seeding, EzPickle
import numpy as np

""" gym/envs/box2d/car_racing.py """

class android_car(gym.Env, EzPickle):
    def __init__(self, verbose=1):
        EzPickle.__init__(self)
        self.golden = [1,2,3,4]
        self.state = [1,1,1,1]
        self.count = 0
    def reset(self):
        self.count = 0
        return
    def step(self, action):
        assert(len(action)>=4)
        self.state[0] += action[0]
        self.state[1] += action[1]
        self.state[2] += action[2]
        self.state[3] += action[3]
        self.count += 1
        step_reward = np.sum(np.array(self.golden) - np.array(self.state))
        if step_reward < 1:
            done = True
        else:
            done = False
        return self.state, step_reward, done, {}
    def render(self):
        print(self.state)
        return self.count < 1000
    def close(self):
        return


def key_press(k, mod):
    if k == key.LEFT: a[0] = 1
    if k == key.RIGHT: a[1] = 1
    if k == key.UP: a[2] = 1
    if k == key.DOWN: a[3] = 1
def key_release(k, mod):
    if k == key.LEFT: a[0] = 0
    if k == key.RIGHT: a[1] = 0
    if k == key.UP: a[2] = 0
    if k == kye.DOWN: a[3] = 0
env = android_car()
env.render()
#env.viewer.window.on_key_press = key_press
#env.viewer.window.on_key_release = key_release
isopen = True
while isopen:
    env.reset()
    total_reward = 0.0
    steps = 0
    restart = False
    while True:
        a = [1,1,1,1]
        s, r, done, info = env.step(a)
        total_reward += r
        if steps % 200 == 0 or done:
            print("step {} total_reward {:+0.2f}".format(steps, total_reward))
        steps += 1
        isopen = env.render()
        if done or restart or isopen == False:
            break
        if steps > 10:
            break
    break
env.close()

