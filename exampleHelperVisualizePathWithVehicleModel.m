function exampleHelperVisualizePathWithVehicleModel(planner, path, ccConfig, interval)
%exampleHelperVisualizePathWithVehicleModel Plot the path with vehicle
%model showed on selected poses.

%   Copyright 2022 The MathWorks, Inc.
show(planner)

% Get the axes handle
hAx = gca;

% Turn hold on
hold(hAx, 'on')

Poses = path.States;
% Select some poses you want to show with vehicle shape
SelectedPoses = Poses(1:interval:end,:);

% Add goal pose if it is not included in the selected poses
if(any(Poses(end,:) ~= SelectedPoses(end,:)))
    SelectedPoses = [SelectedPoses; Poses(end,:)];
end

% Define the color
pathColor  = [0 0.4470 0.7410];

% Draw selected poses
scatter(hAx, SelectedPoses(:,1), SelectedPoses(:,2), [], ...
    pathColor, 'filled');

% Load vehicle dimensions
vdims = ccConfig.VehicleDimensions;
ro = vdims.RearOverhang;
fo = vdims.FrontOverhang;
wb = vdims.Wheelbase;
hw  = vdims.Width/2;
carShapes = polyshape( ...
    [-ro; wb+fo; wb+fo; -ro],...
    [-hw;   -hw;    hw;  hw]);

numPoses = size(SelectedPoses,1);
carShapes = repelem(carShapes, numPoses, 1);

% Create a function handle to translate and rotate
transform = @(shape, x, y, theta)rotate(...
    translate(shape, [x,y]), theta/pi*180, [x,y] );

% Translate and rotate each car to its respective way
% point.
carShapes = arrayfun(transform, carShapes, ...
    SelectedPoses(:,1), SelectedPoses(:,2), SelectedPoses(:,3));

% Finally plot the cars
hShapes = plot(hAx, carShapes, 'FaceColor', pathColor);
for n = 1 : numel(hShapes)
    hShapes(n).Annotation.LegendInformation.IconDisplayStyle = 'off';
end

title('Plan Collision-Free Path for Vehicles With Hybrid A* Planner')

end