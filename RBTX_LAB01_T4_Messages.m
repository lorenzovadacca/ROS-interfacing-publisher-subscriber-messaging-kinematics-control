clear all;close all;clc

%% Initializing ROS
rosinit

%% 
exampleHelperROSCreateSampleNetwork

%%
rostopic list

%%
rosmsg list

%%
posesub = rossubscriber("/pose","DataFormat","struct");
posedata = receive(posesub,10);

%%
rosShowDetails(posedata)

lin_x = posedata.Linear.X;
lin_y = posedata.Linear.Y;
lin_z = posedata.Linear.Z;

ang_x = posedata.Angular.X;
ang_y = posedata.Angular.Y;
ang_z = posedata.Angular.Z;

%%
twist = rosmessage("geometry_msgs/Twist","DataFormat","struct");

rosShowDetails(twist)

twist.Linear.X = 5.0;
twist.Angular.Y = 0.2;

rosShowDetails(twist)

%%
posedata = receive(posesub,20);

save("posedata.mat","posedata")

%%
clear posedata

%%
messageData = load('posedata.mat')


