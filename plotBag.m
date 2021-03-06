%%
clc; clear; close all;
THRESHOLD = 9.5;
UP_FREQ_IDX = 227;
DOWN_FREQ_IDX = 175;
FREQ_INTERVAL = 4;
%%
% Reads bag
bag = rosbag('../tests/silence/bag.bag');
% Gets goal topic messages
goal = select(bag, 'Topic', '/crazyflie/goal');
% Gets times for fftValues messages
tgoal = goal.MessageList.Time;
% Reads goal topic messages
goal = readMessages(goal);
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

% Gets fftValues matrix
fftValues = [fftValues{:}];
fftValues = [fftValues(:).Data];

% Starts times from 0
tmin = min([tfftValues(1), tgoal(1)]);
tfftValues = tfftValues - ones(size(tfftValues)) * tmin;
tgoal = tgoal - ones(size(tgoal)) * tmin;
%%
figure(1)
% Plots goal
s1 = subplot(3,1,1);
hold all;
plot(tgoal, zgoal, 'b')
ylabel('Height in meters')
legend('Goal height')
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