% Computes the fftVales mean in a time interval 
function [pitch, roll] = trimValues(tcmd_vel, cmd_vel_lin_x, cmd_vel_lin_y, cursor_info1, cursor_info2)
    t1 = cursor_info1.Position(1);
    t2 = cursor_info2.Position(1);
    [c index1] = min( abs( tcmd_vel - ones(size(tcmd_vel))*t1 ) );
    [c index2] = min( abs( tcmd_vel - ones(size(tcmd_vel))*t2 ) );
    pitch = mean(cmd_vel_lin_x(index1:index2));
    roll = mean(cmd_vel_lin_y(index1:index2));
end
