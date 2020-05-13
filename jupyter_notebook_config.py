c.ServerProxy.servers = {
        'novnc' : {
            'command': ['/bin/bash', '-c','/jupyterlab/start_novnc.sh'],
            'port': 6080,
            'new_browser_tab': True
            },
        'minio' : {
            'command': ['/bin/bash', '-c', '/jupyterlab/start_minio.sh'],
            'port': 9000,
            'new_browser_tab': True
            },
        'link' : {
            'command': ['python', '-m', 'http.server', '--directory', '/jupyterlab/link', '{port}'],
            'port': 9100,
            'new_browser_tab': True
            }
        }
