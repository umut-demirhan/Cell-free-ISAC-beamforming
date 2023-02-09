% Radar LoS channel generation
% The outer product of LoS beamsteering vectors are multipled with RCS 
function [H] = radar_LOS_channel(target_pos, TX_pos, RX_pos, TX_ant, RX_ant, sigmasq_RCS)

    M_t = size(TX_pos, 1);
    M_r = size(RX_pos, 1);
    T = size(target_pos, 1);
    
    [angle, ~] = compute_angle_dist(TX_pos, target_pos);
    H = beamsteering(angle.', TX_ant);
    H1 = reshape(H, [T, M_t, 1, TX_ant, 1]);
    
    [angle, ~] = compute_angle_dist(target_pos, RX_pos);
    H = beamsteering(angle, RX_ant);
    H2 = reshape(H, [T, 1, M_r, 1, RX_ant]);
    
    RCS = randn(T, M_t, M_r, 1, 1) .* sqrt(sigmasq_RCS);
    H = H1.*H2.*RCS;

end