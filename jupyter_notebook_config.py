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
if False:
    c.ServerProxy.servers['novnc'] = {
            'command': ['/bin/bash', '-c','/jupyterlab/start_novnc.sh'],
            'port': 6080,
            'new_browser_tab': True
        }
if False:
    c.ServerProxy.servers['minio'] = {
            'command': ['/bin/bash', '-c', '/jupyterlab/start_minio.sh'],
            'port': 9000,
            'new_browser_tab': True
        }
