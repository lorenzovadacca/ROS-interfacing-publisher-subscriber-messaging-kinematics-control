clear all;close all;clc

%%
rosinit

%%
fprintf("Available topics BEFORE the publisher creation: \n")
rostopic list

%%
chatterpub = rospublisher("/chatter","std_msgs/String","DataFormat","struct")

fprintf("Available topics AFTER the publisher creation: \n")
rostopic list

%%
chattermsg = rosmessage(chatterpub);
chattermsg.Data = 'Hello world';

%%
send(chatterpub,chattermsg)
rostopic echo /chatter

%%
rosshutdown