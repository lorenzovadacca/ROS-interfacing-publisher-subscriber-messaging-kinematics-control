clear all;close all;clc

%% Initializing ROS
rosinit

%%
fprintf("TwoIntsRequests: \n")
rosmsg show roscpp_tutorials/TwoIntsRequest

fprintf("TwoIntsResponse: \n")
rosmsg show roscpp_tutorials/TwoIntsResponse

%%
sumserver = rossvcserver("/sum","roscpp_tutorials/TwoInts",@exampleHelperROSSumCallback,"DataFormat","struct");

sumclient = rossvcclient("/sum","DataFormat","struct");

%%
sumreq = rosmessage(sumclient)
sumreq.A = int64(2);
sumreq.B = int64(5);
sumreq

%%
if isServerAvailable(sumclient)
    sumresp = call(sumclient,sumreq,"Timeout",3)
else
    error("Service server not available in the network")
end
