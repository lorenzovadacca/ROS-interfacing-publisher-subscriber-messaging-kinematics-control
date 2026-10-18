clear all;close all;clc

%% Initializing ROS
rosinit

%% 
exampleHelperROSStartTfPublisher

%%
tftree = rostf;
pause(2)

%%
pt = rosmesssage('geometry_msgs/PointStamped')
pt.Header.FrameId = 'camera_center'
pt.Point.X = 3;
pt.Point.Y = 1.5;
pt.Point.Z = 0.2;

transformed_pt = transform(tftree,'robot_base',pt)
