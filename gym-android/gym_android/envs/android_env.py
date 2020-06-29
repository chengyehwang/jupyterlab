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
        self.action_space = Tuple((Discrete(2), Discrete(2),Discrete(2),Discrete(2)))
        self.dist_prev = self.dist()
    def dist(self):
        return np.sum(np.abs(np.array(self.golden) - np.array(self.state)))
    def end(self):
        for i in range(4):
            if self.state[i] <= self.golden[i]:
                return False
        return True
    def step(self, action):
        print('action:', action)
        #assert(len(action)>=4)
        self.state[0] += action[0]
        self.state[1] += action[1]
        self.state[2] += action[2]
        self.state[3] += action[3]
        self.count += 1
        dist = self.dist()
        print('dist:', dist)
        if dist < 1:
            done = True
        else:
            done = False
        if self.end():
            done = True
        if dist < self.dist_prev:
            step_reward = 1.0
        else:
            step_reward = -1.0
        
        self.dist_prev = dist
        return self.state, step_reward, done, {}
    def reset(self):
        print('reset:')
        self.state = [1,1,1,1]
        self.count = 0
        return
    def render(self, mode='human'):
        print('state:', self.state)
        return self.count < 1000
    def close(self):
        return

