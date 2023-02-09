function [sum_eigenvalues, ratio] = compute_eigenvector_ratio(Q_star, U)
    S = size(Q_star, 3);   
    sum_eigenvalues = zeros(S, 1);
    for s=1:S
        sum_eigenvalues(s) = trace(Q_star(:, :, s));
    end
    ratio = min(sum_eigenvalues(1:U))/max(sum_eigenvalues(U+1:S));
end