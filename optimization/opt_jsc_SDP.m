function [F_star, feasible, SSNR_opt] = opt_jsc_SDP(H_comm, sigmasq_comm, gamma, sensing_beamsteering, sensing_streams, sigmasq_sens, P_all)

    [U, M, N] = size(H_comm);
    H_st = reshape(H_comm, U, []);
    
    D = zeros(M, M*N, M*N);
    for m = 1:M
        diag_idx = (m:M:M*N);
        D(m, diag_idx, diag_idx) = eye(N);
    end

    a = reshape(sensing_beamsteering, 1, []);
    A = a'*a;

    assert(sensing_streams >= 0);
    num_streams = U+sensing_streams;
    %%
    cvx_begin sdp quiet

        variable F(M*N, M*N, num_streams) hermitian semidefinite

        obj = 0;
        F_stream_sum = sum(F, 3);
        for m_t = 1:M
            Dmt = squeeze(D(m_t, :, :));
            obj = obj + trace(Dmt*A*Dmt*F_stream_sum);
        end
        obj = obj * sigmasq_sens;

        maximize(obj)
        for u = 1:U
            Q_u = (H_st(u, :)'*H_st(u,:));
            L_u = 0;
            for b = 1:num_streams
                if b ~= u
                    L_u = L_u + trace(Q_u*squeeze(F(:, :, b)));
                end
            end
            % The following expression is hermitian but not recognized by CVX
            % Thus, we need the following real - imag
            real((1/gamma) * trace(Q_u*squeeze(F(:, :, u))) - L_u) >=  sigmasq_comm; 
            imag((1/gamma) * trace(Q_u*squeeze(F(:, :, u))) - L_u) == 0;
        
        end
        % Power Constraints
        for m_t=1:M
            Dmt = squeeze(D(m_t, :, :));
            trace(Dmt*F_stream_sum) <= P_all;
        end

    cvx_end
    
    %%
    % Check feasibility of the solution
    if strcmp(cvx_status, 'Solved') % If the problem is feasible
        feasible = true;
        F_star = F;
        SSNR_opt = obj;
    else % If the problem is not feasible
        feasible = false;
        F_star = zeros(M*N, M*N, num_streams);
        SSNR_opt = 0;
    end

end