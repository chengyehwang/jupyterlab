c.ServerProxy.servers = {
        'novnc' : {
            'command': ['/opt/novnc/utils/launch.sh', '--vnc', 'localhost:5901', '--listen', '{port}', '>&', '/tmp/novnc.log', '&'],
            'port': 6080
            },
        'airflow' : {
            'timeout': 20,
            'command': ['/opt/start_airflow.sh','{port}'],
            'port': 8080
            }
        }
