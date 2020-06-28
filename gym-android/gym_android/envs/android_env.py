import gym
from gym import error, spaces, utils
from gym.utils import seeding
import numpy as np
class AndroidEnv(gym.Env):
    metadata = {'render.modes':['human']}
    def __init__(self, verbose=1):
        self.golden = [1,2,3,4]
        self.state = [1,1,1,1]
        self.count = 0
    def step(self, action):
        assert(len(action)>=4)
        self.state[0] += action[0]
        self.state[1] += action[1]
        self.state[2] += action[2]
        self.state[3] += action[3]
        self.count += 1
        step_reward = abs(np.sum(np.array(self.golden) - np.array(self.state)))
        if step_reward < 1:
            done = True
        else:
            done = False
        return self.state, step_reward, done, {}
    def reset(self):
        self.count = 0
        return
    def render(self, mode='human'):
        print(self.state)
        return self.count < 1000
    def close(self):
        return

