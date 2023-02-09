function [F_star_comm, F_star_sensing] = SDP_beam_extraction(F_star, H_comm)
    % Rank-1 Approx.
    [U, M, N] = size(H_comm);
    S = size(F_star, 3);
    F_star_comm = zeros(U, M, N);
    H_comm_stacked = reshape(H_comm, U, []);
    F_comm_sum = 0;
    for u=1:U
        Q_u = F_star(:, :, u).';
        h_u = H_comm_stacked(u, :).';
        f_u = (h_u' * Q_u * h_u)^(-1/2) * Q_u * h_u;
        F_star_u = reshape(f_u, M, N);
        F_star_comm(u, :, :) = F_star_u;
        F_u_hat = f_u * f_u';
        F_comm_sum = F_comm_sum + F_u_hat;
    end
    
    F_star_sensing = zeros(max(S-U, 1), M, N);

     if S > U
        F_star_sum = sum(F_star, 3).';
        F_sens_sum = F_star_sum-F_comm_sum;
        [eigenvec, D] = eig(F_sens_sum);
        [lambda, order] = sort(diag(D), 'descend');
        for s=U+1:S
            F_star_sensing(s-U, :, :) = reshape(sqrt(lambda(s-U))*eigenvec(:, order(s-U)), 1, M, N);
        end
     end

end