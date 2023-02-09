%% Collect the results
clear all;

[res_table, legend_list] = load_results('output', 'power');

%% Prepare Legends
for i = 3:size(res_table, 2)
    txt = strsplit(legend_list{i}, '-');
    tf = strsplit(txt{1}, '+');
    if strcmp('JSC', tf{1})
        legend_list{i} = 'JSC Beam Optimization';
    else
        legend_list{i} = [tf{1}, ' Sensing - ',  tf{2}, ' Comm'];
    end
end

%% Plot the results
set_default_plot;

res_mat_mean = grpstats(res_table, 'Power-ratio');
power_ratio = res_mat_mean{:, 1};
res_mat_mean = res_mat_mean{:, 2:end}; % Remove power ratio

line_style = ["-", ":", "-.", "--", ":"];
marker = ['x', 'o', "square", 'd', '|'];
style_counter = 0;

figure;
for i = 3:size(res_mat_mean, 2)
    if rem(i, 2) == 1
        style_counter = max(1, rem(style_counter + 1, length(line_style)));
        subplot(2, 1, 1);
        title('Communication');
        ylabel('Min Comm SINR');
    else
        subplot(2, 1, 2);
        title('Sensing');
        ylabel('Target SNR')
        xlabel('Communication Power Ratio (\rho)');
    end
    plot(power_ratio, res_mat_mean(:, i), ...
        LineStyle=line_style(style_counter), ...
        Marker=marker(style_counter), ....
        DisplayName=legend_list{i})
    hold on;
    grid on;
end
legend;
