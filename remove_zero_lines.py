
# must be run with python3, otherwise for some reason will not remove all 0 lines

with open("LiDAR_PointCloud.ply", "r") as f:
    lines = f.readlines()
with open("zeros_removed.ply", "w") as f:
    for line in lines:
        if line.strip("\n") != "0.000000 0.000000 0.000000 0 0 0":
            f.write(line)

# In hindsight I don't think we actually need to do this. I had to for my 
# matlab visualizer but whithin our algorithm why do need to remove the 0 
# when we can just calculate around them. Might make things easier or might
# just waste time/cycles.