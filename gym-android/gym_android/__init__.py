from gym.envs.registration import register
register(
        id = 'android-v0',
        entry_point='gym_android.envs:AndroidEnv',
        )
