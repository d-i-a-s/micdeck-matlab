%%
clc; clear; close all;
THRESHOLD = 9.5;
UP_FREQ_IDX = 227;
DOWN_FREQ_IDX = 175;
FREQ_INTERVAL = 4;
%%
% Reads bag
bag = rosbag('../tests/videoV4/bag.bag');
% Gets goal topic messages
goal = select(bag, 'Topic', '/crazyflie/goal');
% Gets times for fftValues messages
tgoal = goal.MessageList.Time;
% Reads goal topic messages
goal = readMessages(goal);

% Gets mocap topic messages
mocap = select(bag, 'Topic', '/crazyflie/vrpn_client_node/crazyflie2/pose');
% Gets times for mocap messages
tmocap = mocap.MessageList.Time;
% Reads mocap topic messages
mocap = readMessages(mocap);

% Gets fftValues topic messages
fftValues = select(bag, 'Topic', '/crazyflie/fftValues');
% Gets times for fftValues messages
tfftValues = fftValues.MessageList.Time;
% Reads fftValues topic messages
fftValues = readMessages(fftValues);
%%
% Gets goal vector for Z coordinate
zgoal = [goal{:}];
zgoal = [zgoal(:).Pose];
zgoal = [zgoal(:).Position];
zgoal = [zgoal(:).Z];

% Gets mocap vector for Z coordinate
zmocap = [mocap{:}];
zmocap = [zmocap(:).Pose];
zmocap = [zmocap(:).Position];
zmocap = [zmocap(:).Z];

% Gets fftValues matrix
fftValues = [fftValues{:}];
fftValues = [fftValues(:).Data];

% Starts times from 0
tmin = min([tfftValues(1), tgoal(1), tmocap(1)]);
tfftValues = tfftValues - ones(size(tfftValues)) * tmin;
tgoal = tgoal - ones(size(tgoal)) * tmin;
tmocap = tmocap - ones(size(tmocap)) * tmin;
%%
figure(1)
% Plots goal and mocap
s1 = subplot(3,1,1);
title('Test "videoV4" data')
hold all;
plot(tgoal, zgoal, 'b')
plot(tmocap, zmocap, 'r')
ylabel('Height in meters')
legend('Goal height','Experimental height')
%%
% Plots fftValues
s2 = subplot(3,1,2);
freqs = linspace(0, 3500, 513);
[X,Y] = meshgrid(freqs, tfftValues);
s = surf(Y, X, fftValues');
s.EdgeColor = 'none';
view(2)
ylabel('Frequency in Hz')

%%
% Plots values used by the sound controller
s3 = subplot(3,1,3);
hold all
plot(tfftValues, mean(fftValues((UP_FREQ_IDX - FREQ_INTERVAL):(UP_FREQ_IDX + FREQ_INTERVAL), :)))
plot(tfftValues, mean(fftValues((DOWN_FREQ_IDX - FREQ_INTERVAL):(DOWN_FREQ_IDX + FREQ_INTERVAL), :)),'r')
plot(tfftValues, ones(size(tfftValues))*THRESHOLD,'g')
ylabel('Amplitude in dB')
legend('Up frequency', 'Down frequency', 'Threshold')
linkaxes([s1, s2, s3],'x')
xlabel('Time in seconds')