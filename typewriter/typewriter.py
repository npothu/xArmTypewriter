# typewriter
"""
Description: TypeWriter
To Do: Update desc, compatibillity w/ all fonts, clean-up code
"""
import os
import time
from xarm.wrapper import XArmAPI

ip = '192.168.1.217' # Substitute for your Robot IP
arm = XArmAPI(ip)
arm.motion_enable(enable=True)
arm.set_mode(0)
arm.set_state(state=0)
speed = 80
acceleration = 10


filepath = os.path.dirname(os.path.realpath(__file__)) + '\positions.csv'
cTime = os.path.getmtime(filepath)

i = 0
n = 0

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
                    arm.set_position(coords[0],coords[1],coords[2],180,90,180, speed=speed) 
                    print("i")
                    if i%25 == 0:
                        start = coords
                    elif i%25 == 1:
                        start2 = coords
                    elif i%25 == 2:
                        start3 = coords
                        

                    if (i+1)%25 == 0:
                        arm.set_position(start[0],start[1],start[2],180,90,180)
                        arm.set_position(start2[0],start2[1],start2[2],180,90,180)
                        arm.set_position(start3[0],start3[1],start3[2],180,90,180)
                        arm.set_position(start3[0],start3[1],110,180,90,180)
                    n+=1
                i+=1
arm.disconnect();
