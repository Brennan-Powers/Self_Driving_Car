clear;

s = get(0, 'ScreenSize');
figure('Position', [0 0 s(3) s(4)]);

for i=0 : 100
    %ptcloud = plyread('/home/bpowers/404Robots/gta/frames/output' + i + '.ply');
    s1 = '/home/bpowers/404Robots/gta/frames/output';
    s2 = '.ply';
    s3 = strcat(s1, int2str(i), s2)
    ptcloud = plyread(s3);
    %disp(i);
    ix=(ptcloud.vertex.x~=0);
    % black points are indestructable objects
    % need to do ix & rgb 255 255 255
    black = ix & ((ptcloud.vertex.red==255) & (ptcloud.vertex.green==255) & (ptcloud.vertex.blue==255));
    red = ix & ((ptcloud.vertex.red==255) & (ptcloud.vertex.green==0) & (ptcloud.vertex.blue==0));
    blue = ix & ((ptcloud.vertex.red==0) & (ptcloud.vertex.green==0) & (ptcloud.vertex.blue==255));
    green = ix & ((ptcloud.vertex.red==0) & (ptcloud.vertex.green==255) & (ptcloud.vertex.blue==0));
    %hold off;
    %hold on;
    %view(2);
    plot3(ptcloud.vertex.x(black,1), ptcloud.vertex.y(black,1), ptcloud.vertex.z(black,1), '.', 'color', 'black');
    hold on;
    %view(2);
    plot3(ptcloud.vertex.x(red,1), ptcloud.vertex.y(red,1), ptcloud.vertex.z(red,1), '.', 'color', 'red');
    plot3(ptcloud.vertex.x(blue,1), ptcloud.vertex.y(blue,1), ptcloud.vertex.z(blue,1), '.', 'color', 'blue');
    plot3(ptcloud.vertex.x(green,1), ptcloud.vertex.y(green,1), ptcloud.vertex.z(green,1), '.', 'color', 'green');
    %hold off;
    pause(.3);
    
    
    %disp("This is testing" + i + ".ply");
    %clear;
    %close all;
    %ix = [];
    %ptcloud = [];
end