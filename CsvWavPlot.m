%%
clc; close all; clear;
%%
prefix = '../';
file = '29-11_13:35:21';

[crec, cfs] = audioread(strcat(prefix, file, '.wav'));
csv = csvread(strcat(prefix, file, '.csv'));

%%
figure(1)
hold all
t = 0:1/cfs:(1/cfs*(length(crec)-1));
plot(t,crec, 'b')

figure(2)
t = 0:1/cfs:(1/cfs*(length(crec)-1));
plot(t,csv, 'b')

figure(3)
spectrogram(crec,256,128,1024,cfs);