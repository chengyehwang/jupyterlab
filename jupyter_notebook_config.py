c.ServerProxy.servers = {
        'minio' : {
            'command': ['python', '-m', 'http.server', '--directory', '/jupyterlab/link/minio', '{port}'],
            'port': 9100,
            'new_browser_tab': True
            },
        'xpra' : {
            'command': ['python', '-m', 'http.server', '--directory', '/jupyterlab/link/xpra', '{port}'],
            'port': 9101,
            'new_browser_tab': True
            }
        }
