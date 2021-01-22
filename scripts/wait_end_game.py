import time
import subprocess
import requests


while True:
    time.sleep(5) # 0.2 fps
    resp = requests.get("http://localhost:5000/warState")
    print(resp.text)
    if "stop" in resp.text:
    	time.sleep(5)
        print "The game is finished."
        break
