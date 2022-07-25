#! /bin/bash -e

#Xvfb :99 -screen 0 640x480x8 -nolisten tcp &
python3 flask-helloworld.py &

#xvfb-run --listen-tcp --server-num 44 --auth-file /tmp/xvfb.auth -s "-ac -screen 0 640x480x8"

pytest selenium_example.py

pkill -e 'python3 flask-helloworld.py'
