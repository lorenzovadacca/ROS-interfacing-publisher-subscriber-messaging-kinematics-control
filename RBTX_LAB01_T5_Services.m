clear all;close all;clc

%% Initializing ROS
%rosinit

%%
fprintf("Available service BEFORE fake network creation: \n")
rosservice list

%%
exampleHelperROSCreateSampleNetwork

%%
fprintf("Available service AFTER fake network creation: \n")
rosservice list

%%
testserver = rossvcserver("/test","std_srvs/Empty",@exampleHelperROSEmptyCallback,"DataFormat","struct");
rosservice list

%%
rosservice info /test
rosservice type /test

%%
testclient = rossvcclient("/test","DataFormat","struct");
testreq = rosmessage(testclient);

%%
waitForServer(testclient,"Timeout",3)

%%
testresp = call(testclient,testreq,"Timeout",3);

%%
rosshutdown