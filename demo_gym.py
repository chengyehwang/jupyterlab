# +
import gym
from RL_brain import DeepQNetwork
env = gym.make('gym_android:android-v0')
print(env.action_space)

RL = DeepQNetwork(n_actions=4, n_features=4, learning_rate=0.001, e_greedy=0.9,
                  replace_target_iter=300, memory_size=4000,
                  e_greedy_increment=0.0002,)
# -


# # Training

for game_count in range(2000):
    observation = env.reset()
    for game_step in range(1000):
        env.render()
        action = RL.choose_action(observation)
        observation_, reward, done, info = env.step(action)
        RL.store_transition(observation, action, reward, observation_)
        observation = observation_
        if done:
            #print('done & learn')
            RL.learn()
            break
RL.plot_cost()
# # Testing

for i in range(10):
    observation = env.reset()
    for game_step in range(1000):
        env.render()
        action = RL.choose_action(observation)
        observation_, reward, done, info = env.step(action)
        observation = observation_
        if done:
            print(observation)
            break


