
clear;

% uses toolbox we don't have, but might be able to get through the school.
% Might really help us or might not, probably depends on weather or not we
% want to do this project in matlab or a different language.
%ptCloud = pcread('LiDAR_PointClout.ply');
%pcshow(ptCloud);

% North = +Y axis
% East = +X axis

%ptcloud = plyread('LiDAR_PointCloud.ply');

%ptcloud = plyread('LiDAR_PointCloud_inCar_with_vpilot.ply');
%ptcloud = plyread('LiDAR_PointCloud_backcountry.ply');
%ptcloud = plyread('LiDAR_PointCloud_people.ply');
%ptcloud = plyread('LiDAR_PointCloud_5_5.ply');
%ptcloud = plyread('LiDAR_PointCloud_0_10.ply');
%ptcloud = plyread('LiDAR_PointCloud_B.ply');
%ptcloud = plyread('LiDAR_PointCloud_City_with_stoplight.ply');
%ptcloud = plyread('LiDAR_PointCloud_City2.ply');
%ptcloud = plyread('LiDAR_PointCloud_range_20.ply');
%ptcloud = plyread('LiDAR_PointCloud_range20_step11.ply');
%ptcloud = plyread('David_test.ply');
%ptcloud = plyread('LiDAR_PointCloud_motocycle1.ply');
%ptcloud = plyread('LiDAR_PointCloud_motocycle2.ply');
%ptcloud = plyread('LiDAR_PointCloud_motocycle3.ply');
%ptcloud = plyread('LiDAR_PointCloud_motocycle4.ply');


% make an array of n by 3 where each row is a point.
for i=1 : size(ptcloud.vertex.x, 1)
    allPoints(i,1) = ptcloud.vertex.x(i,1);
    allPoints(i,2) = ptcloud.vertex.y(i,1);
    allPoints(i,3) = ptcloud.vertex.z(i,1);
    allPoints(i,4) = ptcloud.vertex.red(i,1);
    allPoints(i,5) = ptcloud.vertex.green(i,1);
    allPoints(i,6) = ptcloud.vertex.blue(i,1);
end

% remove all points that are at (0,0,0) while resizing array.
% i = 1;
% while i <= size(allPoints, 1)
%     if (allPoints(i,1) == 0) && (allPoints(i,2) == 0) && (allPoints(i,3) == 0)
%         allPoints(i,:) = [];
%         i = i-1;
%     end
%     i = i+1;
% end

% faster way to remove rows of all zeros or NaN
allPoints = allPoints(any(allPoints,2),:);

% initialize 4 arrays for the 4 different kind of points lidar detects
landscape = [0 0 0];
vehicles = [0 0 0];
people = [0 0 0];
props = [0 0 0];

% filling 4 point cloud arrays. Colors listed are what the lidar listed
% them as, but I change them when plotting.
for i=1 : size(allPoints, 1)
    if (allPoints(i,4) == 255) && (allPoints(i,5) == 255) && (allPoints(i,6) == 255)
        % white: terraint, buildings
        landscape = [landscape; allPoints(i,1:3)];
    elseif (allPoints(i,4) == 255) && (allPoints(i,5) == 0) && (allPoints(i,6) == 0)
        % red: vehicles
        vehicles = [vehicles; allPoints(i,1:3)];
    elseif (allPoints(i,4) == 0) && (allPoints(i,5) == 255) && (allPoints(i,6) == 0)
        % green: people, animals
        people = [people; allPoints(i,1:3)];
    elseif (allPoints(i,4) == 0) && (allPoints(i,5) == 0) && (allPoints(i,6) == 255)
        % blue: game props, things you can knock over with your car
        props = [props; allPoints(i,1:3)];
    else
        % Some kinda error
    end 
end

% remove the first row on each array, that [0 0 0] that initialized them.
landscape(1,:) = [];
vehicles(1,:) = [];
people(1,:) = [];
props(1,:) = [];

% hold on makes the 4 plots below happen on the same plot instead of
% replacing the previous one.
hold on;

% plot the 4 arrays with their remapped color.
plot3(landscape(:,1), landscape(:,2), landscape(:,3), '.', 'color', 'black');
plot3(vehicles(:,1), vehicles(:,2), vehicles(:,3), '.', 'color', 'red');
plot3(people(:,1), people(:,2), people(:,3), '.', 'color', 'green');
plot3(props(:,1), props(:,2), props(:,3), '.', 'color', 'magenta');

