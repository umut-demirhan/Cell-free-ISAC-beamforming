% The following position functions will be called in each repetition
function [UE_pos, AP_pos, target_pos] = generate_positions(T, U, M_t, line_length, distance_target, distance_UE, min_dist, max_dist)
    AP_pos = [[25; 75], zeros(M_t, 1)];
    cur_min_dist = -1000;
    while (cur_min_dist < min_dist) || (cur_min_dist > max_dist)
        target_pos = [rand(T, 1)*line_length, distance_target*ones(T, 1)];  
        UE_pos = [rand(U, 1)*line_length, distance_UE*ones(U, 1)];
        [~, distance] = compute_angle_dist(UE_pos, target_pos);
        cur_min_dist = min(distance);
    end
end