%%
clc; close all; clear;
%% Reads data from csv and wav files

% Crazyflie recording and Crazyflie sampling frequency
[crec, cfs] = audioread('../CrazyMicRecording.wav');
% Normalization
crec = crec - mean(crec) * ones(size(crec));
crec = crec / max(crec);
% Crazyflie time stamp
ctstamp = csvread('../CrazyMicTimeStamps.csv');
% Number of samples between each time stamp
csize = 19;

% PC recording and PC sampling frequency
[prec, pfs] = audioread('../PCMicRecording.wav');
prec = prec / max(prec);
% PC time stamp
ptstamp = csvread('../PCMicTimeStamps.csv');
% Number of samples between each time stamp
psize = 1024;
%
tmin = min([ctstamp(1), ptstamp(1)]);
ctstamp = ctstamp - ones(size(ctstamp)) * tmin;
ptstamp = ptstamp - ones(size(ptstamp)) * tmin;

%% Plots data taking into account all the time stamps
figure(1);
hold all;

% Crazyflie recording
for i= 0:1:(length(ctstamp) - 2)
    plt = crec((i*csize + 1):((i + 1)*csize));
    times = linspace(ctstamp(i + 1) - 1/cfs*(csize - 1), ctstamp(i + 1), csize);
    plot(times, plt, 'b')
end

% PC recording
for i= 0:1:(length(ptstamp) - 2)
    plt = prec((i*psize + 1):((i + 1)*psize));
    times = linspace(ptstamp(i + 1) - 1/pfs*(psize - 1), ptstamp(i + 1), psize);
    plot(times, plt, 'r')
end

%% Plots data taking into account a time stamp after the communication stablized
figure(2);
hold all;

i = 1000;
plt = crec((i*csize + 1):end);
times = (ctstamp(i + 1) - 1/cfs*(csize - 1))*ones(size(plt)) + (0:1:(size(plt, 1) - 1))' * 1/cfs;
plot(times, plt, 'b')

i = 100;
plt = prec((i*psize + 1):end);
times = (ptstamp(i + 1) - 1/pfs*(psize - 1))*ones(size(plt)) + (0:1:(size(plt, 1) - 1))' * 1/pfs;
plot(times, plt, 'r')

%% Plots time stamps
figure(3)
hold all;
plot(ctstamp, 'b')
plot(ptstamp, 'r')
legend('Crazyflie time stamps', 'PC time stamps')