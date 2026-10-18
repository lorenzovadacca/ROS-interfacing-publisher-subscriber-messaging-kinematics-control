clear all;close all;clc

%% Initializing ROS
rosinit

%% List nodes
rosnode list

%% Create a sample network
exampleHelperROSCreateSampleNetwork

%% List topics
rostopic list

%% Returns a list of publishers, subscribers and message types
rostopic info /pose

%% Returns message types
rostopic type /pose

%% Returns information that is flowing inside a specific topic
rostopic echo /pose

%% Shutting down ROS
rosshutdown