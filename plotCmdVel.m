%%
clc; clear; close all;
%% 
% Reads bag
bag = rosbag('../tests/videoV3/bag.bag');
% Gets cmd_vel topic messages
cmd_vel = select(bag, 'Topic', '/crazyflie/cmd_vel');
% Gets cmd_vel for fftValues messages
tcmd_vel = cmd_vel.MessageList.Time;
% Reads cmd_vel topic messages
cmd_vel = readMessages(cmd_vel);
% Starts times from 0
tcmd_vel = tcmd_vel - ones(size(tcmd_vel)) * tcmd_vel(1);

cmd_vel = [cmd_vel{:}];
cmd_vel_lin = [cmd_vel(:).Linear];
cmd_vel_lin_x = [cmd_vel_lin(:).X];
cmd_vel_lin_y = [cmd_vel_lin(:).Y];
cmd_vel_lin_z = [cmd_vel_lin(:).Z];

cmd_vel_ang = [cmd_vel(:).Angular];
cmd_vel_ang_x = [cmd_vel_ang(:).X];
cmd_vel_ang_y = [cmd_vel_ang(:).Y];
cmd_vel_ang_z = [cmd_vel_ang(:).Z];

% Plots all cmd_vel values
figure(1)
hold all
plot(tcmd_vel,cmd_vel_lin_x);
plot(tcmd_vel,cmd_vel_lin_y);
plot(tcmd_vel,cmd_vel_lin_z);
plot(tcmd_vel,cmd_vel_ang_x);
plot(tcmd_vel,cmd_vel_ang_y);
plot(tcmd_vel,cmd_vel_ang_z);
legend('lin_x','lin_y','lin_z', 'ang_x', 'ang_y', 'ang_z')