function best_parameter = linear_parameter_search(eval_fun, gen_fun, x_min, x_max, spacing)
    test_values = linspace(x_min, x_max, spacing);

    res = zeros(1, length(test_values));

    for i = 1:length(test_values)
        res(i) = min(eval_fun(gen_fun(test_values(i))));
    end
    
    [~, max_idx] = max(res);
    best_parameter = test_values(max_idx);
end