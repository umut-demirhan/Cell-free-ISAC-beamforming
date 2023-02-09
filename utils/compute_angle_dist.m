%% 2D Distance & Angle Computation
%
% Computes angle and distance between each pair of 
% position1 (Mx2) and position2 (Nx2)
%
% The output is MxN matrices of 
% angle (from pos1 to pos2) in radians
% and Euclidian distance
%
function [angle, euc_dist] = compute_angle_dist(pos1, pos2)

    % Check size
    assert(length(size(pos1)) == 2);
    assert(length(size(pos2)) == 2);
    assert(size(pos1, 2) == 2);
    assert(size(pos2, 2) == 2);
    M = size(pos1, 1);
    N = size(pos2, 1);
    
    a = reshape(pos1, M, 1, 2); % (M x 1 x 2)
    b = reshape(pos2, 1, N, 2); % (1 x N x 2)
    
    dist_vec = b-a; % Difference (M x N x 2)
    euc_dist = sqrt(sum(dist_vec.^2, 3));
    
    angle = atan2(dist_vec(:, :, 2), dist_vec(:, :, 1)); 
    % Angle quadrant problem is fixed with atan2, 
    % i.e., x pos y neg still returns pos angle at 90+.
end

