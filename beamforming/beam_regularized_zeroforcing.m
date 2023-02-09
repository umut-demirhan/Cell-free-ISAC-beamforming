function F = beam_regularized_zeroforcing(varargin)

    H = varargin{1};
    P_comm = varargin{2};
    sigmasq_comm = varargin{3};
    [U, M, N] = size(H);

    if nargin == 3
        lambda = U*sigmasq_comm/P_comm;
    else
        lambda = varargin{4};
    end

    H_stacked = reshape(H, U, []);
    F_stacked = pinv(eye(U)*lambda + H_stacked * H_stacked')*H_stacked;
    F = reshape(F_stacked, U, M, N);
    F = beam_normalization(F, 'UE');

end
     