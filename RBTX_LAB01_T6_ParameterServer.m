clear all;close all;clc

%% Initializing ROS
%rosinit

%%
ptree = rosparam

has(ptree,'ROBOT_IP')

%%
set(ptree, 'ROBOT_IP', '192.168.1.1');
set(ptree, '/myrobot/ROBOT_IP','192.168.1.100');
set(ptree, 'MAX_SPEED',1.5);
set(ptree, 'goal',{5.0,2.0,0.0});
set(ptree, '/myrobot/MAX_SPEED',2.0);
set(ptree, '/newrobot/ROBOT_NAME','NEW_TURTLE');

%%
fprintf("Available ROS parameters: \n")
plist = ptree.AvailableParameters;

%%
myrobot_params = get(ptree, "/myrobot")

%%
has(ptree,'goal')
del(ptree,'goal')

%%
results = search(ptree,'myrobot')

%%
rosshutdown
