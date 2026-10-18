clear all;close all;clc

%% Initializing ROS
rosinit

%% 
exampleHelperROSStartTfPublisher

%%
tftree = rostf;
pause(2)

%%
fprintf("Available frames: \n")
tftree.AvailableFrames

%%
tfStampedMsg = rosmessage('geometry_msgs/TransformStamped')

%%
tfStampedMsg.ChildFrameId = 'wheel'
tfStampedMsg.Header.FrameId = 'robot_base';

tfStampedMsg.Transform.Translation.X = 0;
tfStampedMsg.Transform.Translation.Y = -0.2;
tfStampedMsg.Transform.Translation.Z = -0.3;

quatrot = axang2quat([0 1 0 deg2rad(30)])

tfStampedMsg.Transform.Rotation.W = quatrot(1);
tfStampedMsg.Transform.Rotation.X = quatrot(2);
tfStampedMsg.Transform.Rotation.Y = quatrot(3);
tfStampedMsg.Transform.Rotation.Z = quatrot(4);

tfStampedMsg.Header.Stmp = rostime("now");

%%
sendTransform(tftree,tfStampedMsg)

%%
fprintf("Available frames: \n")
tftree.AvailableFrames

%%
exampleHelperROSStopTf Publisher

%%
roshshutdown







