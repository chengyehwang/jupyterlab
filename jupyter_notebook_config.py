c.ServerProxy.servers = {
        'novnc' : {
            'command': ['/bin/bash', '-c','/opt/novnc/utils/launch.sh --vnc localhost:5901 --listen 6080 >/tmp/novnc.log 2>&1'],
            'port': 6080,
            'new_browser_tab': True
            },
        'minio' : {
            'command': ['pwd'],
            'port': 9000,
            'new_browser_tab': True
            }
        }
