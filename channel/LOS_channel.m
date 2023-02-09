% LOS channel from x_pos to y_pos with x_ant and y_ant=1
function [H] = LOS_channel(x_pos, y_pos, x_ant)
    
    [angle, ~] = compute_angle_dist(x_pos, y_pos); 
    H = beamsteering(angle.', x_ant); % y by x
    
end