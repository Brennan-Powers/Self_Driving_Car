#!/usr/bin/env python3

def send2file(lidar, outputFile):
    inputfile = open(lidar, 'r')
    with open(outputFile, 'w+') as file:
        for line in inputfile:
            file.write(line)
    inputfile.close()    
     

