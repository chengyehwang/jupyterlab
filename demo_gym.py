import gym
from RL_brain import QLearningTable
env = gym.make('gym_android:android-v0')
RL = QLearningTable(actions=list(range(env.n_actions)))


# +
for game_count in range(20):
    observation = env.reset()
    for game_step in range(1000):
        env.render()
        action = RL.choose_action(str(observation))

        action = env.action_space.sample()
        observation_, reward, done, info = env.step(action)
        RL.learn(str(observation), action, reward, str(observation_))
        observation = observation_
        if done:
            print('done')
            break
env.close()


# -



