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
mountToCamera = getTransform(tftree, 'mopunting_point', 'camera_center')

%%
mountToCameraTranslation = mountToCamera.Transform.Translation
