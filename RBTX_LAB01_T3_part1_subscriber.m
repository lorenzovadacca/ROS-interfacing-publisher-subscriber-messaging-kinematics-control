clear all;close all;clc

%% Initializing ROS
rosinit

%% Create sample network
exampleHelperROSCreateSampleNetwork

%% List topics
rostopic list

%% Subscribes a message on a topic
laser = rossubscriber("/scan","DataFormat","struct")

%% Wait for new message
scandata = receive(laser,10)

%%
figure
rosPlot(scandata,"MaximumRange",7)

%%
robotpose = rossubscriber("/pose",@exampleHelperROSPoseCallback,"DataFormat","struct")

global pos
global orient

for k=1:100
    fprintf("Data received from callback:  \n")
    pos
    orient
    pause(0.1)
end

