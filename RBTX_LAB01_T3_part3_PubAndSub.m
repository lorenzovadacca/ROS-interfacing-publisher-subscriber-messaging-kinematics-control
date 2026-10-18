clear all;close all;clc

%% Initializing ROS
rosinit

%%
chatterpub = rospublisher("/chatter","std_msgs/String","DataFormat","struct");
chattermsg = rosmessage(chatterpub);
chattermsg.Data = 'Hello world';

%%
chattersub = rossubscriber("/chatter","std_msgs/String",@exampleHelperROSChatterCallback);

%%
for k = 1:10
    fprintf("Call number %g \n",k)
    send(chatterpub,chattermsg)
    pause(2)
end

%%
rosshutdown