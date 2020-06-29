import gym
from gym import error, spaces, utils
from gym.utils import seeding
from gym.spaces import Tuple, Box, Discrete
import numpy as np
class AndroidEnv(gym.Env):
    metadata = {'render.modes':['human']}
    def __init__(self, verbose=1):
        self.golden = [1,2,3,4]
        self.state = [1,1,1,1]
        self.count = 0
        self.action_space = Tuple((Discrete(2), Box(-10,10,(2,))))
    def step(self, action):
        print(action)
        print(action[1][0])
        #assert(len(action)>=4)
        self.state[0] += 1 if action[1][0] > 0 else 0
        self.state[1] += 1 if action[1][0] < 0 else 0
        self.state[2] += 1 if action[1][1] > 0 else 0
        self.state[3] += 1 if action[1][1] < 0 else 0
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

