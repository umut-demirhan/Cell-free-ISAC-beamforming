function power = compute_power(F)
    power = sum(sum(abs(F).^2, 3), 1);
end