clear all;clc;close all

%%
bag = rosbag("ros_turtlesim.bag")

%%
bSel = select(bag,"Topic","/turtle1/pose")

%%
msgStructs= readMessages(bSel,"DataFormat","struct")
fprintf("Example of message: \n")
msgStructs(1)

%%
xPoints =cellfun(@(m double(m.X), msgStructs)
yPoints =cellfun(@(m double(m.Y), msgStructs)
plot(xPoints,yPoints)