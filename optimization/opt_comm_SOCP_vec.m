function [F_star, feasible] = opt_comm_SOCP_vec(H_comm, sigmasq_comm, P_comm, F_sensing, gamma)

    [U, M, N] = size(H_comm);
    H_st = reshape(H_comm, U, []); % U x M_t N_t - h_u has different order than paper
                            % the APs are stacked for each antenna [[H_u]_1n [H_u]_2n ... [H_u]_Mn]
    [T, ~, ~] = size(F_sensing);
    F_sensing_st = reshape(F_sensing, T, []);
    
    D = zeros(M, M*N, M*N);
    for m = 1:M
        diag_idx = (m:M:M*N); % To address the different order of antenna/AP stack
        D(m, diag_idx, diag_idx) = eye(N);
    end


    % cvx_solver Gurobi % Set solver if needed
    cvx_begin quiet

    variable F(U, M*N) complex

    % Feasibility problem without objective

    subject to

        % SINR constraints
        for u = 1:U
            norm([H_st(u, :) * F', H_st(u, :) *F_sensing_st',  sqrt(sigmasq_comm)]) ...
                                            <= sqrt(1 + 1/gamma)*real(H_st(u, :)*F(u, :)');
        end

        % Power constraints
        for m = 1:M
            sum(sum(pow_abs(F*squeeze(D(m, :, :)), 2))) <= P_comm;
        end
    cvx_end

    if strcmp(cvx_status, 'Solved') % If the problem is feasible
        feasible = true;
        F_star = reshape(F, U, M, N);
    else % If the problem is not feasible
        feasible = false;
        F_star = zeros(U, M, N);
    end

end

