function SINR = compute_SINR(H_comm, F_comm, F_sensing, sigmasq_ue)
    [U, M_t, N_t] = size(H_comm);
    comm_signal_pow = abs(sum(sum(conj(H_comm).*F_comm, 3), 2)).^2;
    H_comm_exp = reshape(H_comm, [U, 1, M_t, N_t]);
    F_star_exp = reshape(F_comm, [1, U, M_t, N_t]);
    sum_pow = sum(abs(sum(sum(conj(H_comm_exp).*F_star_exp, 4), 3)).^2, 2);
    sensing_interference = 0;
    for s = 1:size(F_sensing, 1)
        sensing_interference = sensing_interference + abs(sum(sum(conj(H_comm).*F_sensing(s, :, :), 3), 2)).^2;
    end
    SINR= comm_signal_pow./(sum_pow - comm_signal_pow + sensing_interference + sigmasq_ue);

end