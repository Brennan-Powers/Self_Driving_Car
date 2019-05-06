  #!/usr/bin/env python3
# -*- coding: utf-8 -*-

#add open file for lidar and start analyzing the data

from deepgtav.messages import Start, Stop, Scenario, Commands, frame2numpy
from deepgtav.client import Client
from saveOutput import *

import argparse
import time
import cv2
import pyautogui
import re

#Scenario Variables
scen_vehicle = 'Vader'
scen_weather = 'EXTRASUNNY'
scen_drivingmode = -1
#Boolean to choose if lidar
lidar_bool = true;

class Model:
    def run(self,frame):
        return [0.0, 0.0, 0.0] # throttle, brake, steering
        
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=None)
    parser.add_argument('-l', '--host', default='localhost', help='The IP where DeepGTAV is running')
    parser.add_argument('-p', '--port', default=8000, help='The port where DeepGTAV is running')
    args = parser.parse_args()

    client = Client(ip=args.host, port=args.port)
    
    scenario = Scenario(weather=scen_weather,vehicle=scen_vehicle,time=[12,0],drivingMode=[scen_drivingmode,1.0],location=[-619.2719, -179.77854, 0])

    
    client.sendMessage(Start(scenario=scenario))
    
    model = Model()

    stoptime = time.time() + 80*3600
    count = 0
    lidarcfg = "LiDAR GTA V Configuration File\r\nHorizontal_FOV_Min = 0.0\r\nHorizontal_FOV_Max = 360.0\r\nVertical_FOV_Min = -20.0\r\nVertical_FOV_Max = 10.0\r\nHorizontal_Step = 5\r\nVertical_Step = .25\r\nRange = 50\r\nFilename = LiDAR_PointCloud"
    while time.time() < stoptime:
        try:
            message = client.recvMessage()  
                
            image = frame2numpy(message['frame'], (320,160))
            #commands = model.run(image)

            commands = [0,0,0]

            if (lidar_bool == true)
            {
                  pyautogui.press('f6')
            }
            
            time.sleep(1)
            with open("D:\\SteamLibrary\\steamapps\\common\\Grand Theft Auto V\\LiDAR GTA V\\LiDAR GTA V.cfg", 'w') as f:
                f.write(lidarcfg + str(count))
            count += 1
            time.sleep(1)
            
            #with open("C:\Program Files (x86)\Steam\steamapps\common\Grand Theft Auto V\LiDAR GTA V/LiDAR_PointCloud.ply","r") as f: # needs to be same as where your lidar sends the ply file
        
                #for i, line in enumerate(f):
                    #if i == 70: # reads line 50
                        #print line
                        #rgb code for red: 255 0 0
                        #line_list = line.split()
                        #print line_list
                        #if (int(line_list[3]) == 255) and (int(line_list[4]) == 0) and (int(line_list[5]) == 0):
                        #    print ("There is a vehicle in front of you.")
                        #    commands = [0.0, 1.0, 0.0]
                        #elif (int(line_list[3]) == 0) and (int(line_list[4]) == 255) and (int(line_list[5]) == 0):
                        #    print ("There is a person in front of you.")
                        #    commands = [0.0, 1.0, 0.0]

                        #break
                
				
            #commands = [1, 0.0, 0.0]
            client.sendMessage(Commands(commands[0], commands[1], commands[2]))
        except KeyboardInterrupt:
            break
            
    client.sendMessage(Stop())
    client.close()
