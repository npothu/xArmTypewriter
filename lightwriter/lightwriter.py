# Lightwriter
"""
Description: Draw w/ Light
"""
import os
import time

from xarm.wrapper import XArmAPI
from pythonosc.udp_client import SimpleUDPClient
ip = '192.168.1.217'
arm = XArmAPI(ip)
arm.motion_enable(enable=True)
arm.set_mode(0)
arm.set_state(state=0)
speed = 50 
acceleration = 10

ipp = "192.168.1.10"
port = 55555
client = SimpleUDPClient(ipp, port)

i,n = 0


filepath = os.path.dirname(os.path.realpath(__file__)) + '\positions.csv'
cTime = os.path.getmtime(filepath)

while True:
    time.sleep(2)
    mTime = os.path.getmtime(filepath)
    if cTime > mTime:
        print(mTime)
    if cTime < mTime:
        i = 0
        cTime = mTime
        with open(filepath) as f:
            for coords in f:
                coords = f.readline().split(",")
                if i >= n:
                    print(i,n)
                    arm.set_position(coords[0],coords[1],coords[2],180,90,180) #0, 90, 0
                    # turn light on
                    client.send_message("/fill", [255,0,0,0])
                    
                    if i%25 == 0:
                        start = coords
                    elif i%25 == 1:
                        start2 = coords
                    elif i%25 == 2:
                        start3 = coords
                    
                    if (i+1)%25 == 0:
                        # turn light off
                        print("hello")
                        time.sleep(5)
        
                    
                    n+=1
                i+=1
arm.disconnect()
