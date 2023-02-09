function [F_star_all, feasible_SINR] = bisection_SINR(low, high, tol, fun)
    % fprintf('\nBisection:')
    F_star_all = [];
    feasible_SINR = [];
    while (high-low)>tol
        mid = (high+low)/2;
        [F_star, feasible] = fun(mid);
    
        if feasible
            low = mid;
            % fprintf('\n-Setting min to %.4f', low);
            F_star_all = F_star;
            feasible_SINR = mid;
        else
            high = mid;
            if isempty(F_star_all) % If no solution found..
                F_star_all = F_star;
            end
            % fprintf('\n+Setting max to %.4f', high);
        end
    end
    % fprintf('\nBisection completed.\n')
end
