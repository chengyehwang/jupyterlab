import gym
from gym import error, spaces, utils
from gym.utils import seeding
from gym.spaces import Tuple, Box, Discrete
import numpy as np
class AndroidEnv(gym.Env):
    metadata = {'render.modes':['human']}
    def __init__(self, verbose=False):
        self.verbose = verbose
        self.golden = [1,2,3,4]
        self.state = [1,1,1,1]
        self.action_space = Tuple((Discrete(4),))
        self.dist_prev = self.dist()
    def dist(self):
        return np.sum(np.abs(np.array(self.golden) - np.array(self.state)))
    def end(self):
        for i in range(4):
            if self.state[i] <= self.golden[i]:
                return False
        return True
    def get_obs(self):
        ram = np.zeros(4, dtype=np.uint8)
        for i in range(4):
            ram[i] = self.state[i]
        return ram
    def step(self, action):
        if self.verbose:
            print('action:', action)
        #assert(len(action)>=4)
        if action == 0:
            self.state[0] += 1
        elif action == 1:
            self.state[1] += 1
        elif action == 2:
            self.state[2] += 1
        elif action == 3:
            self.state[3] += 1
        ob = self.get_obs()
        dist = self.dist()
        if self.verbose:
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
        return ob, step_reward, done, {}
    def reset(self):
        if self.verbose:
            print('reset:')
        self.state = [1,1,1,1]
        return self.get_obs()
    def render(self, mode='human'):
        if self.verbose:
            print('state:', self.state)
    def close(self):
        return

