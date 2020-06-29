import gym
env = gym.make('gym_android:android-v0')

# +
for game_count in range(20):
    env.reset()
    for game_step in range(1000):
        env.render()
        action = env.action_space.sample()
        observation, reward, done, info = env.step(action)
        if done:
            print('done')
            break
env.close()


# -



