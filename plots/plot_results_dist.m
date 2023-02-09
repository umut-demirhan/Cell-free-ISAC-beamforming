%% Collect the results
clear all;

[res_table, legend_list] = load_results('output', 'dist');


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

dist_groups = discretize(res_table.('Min UE-Target Distance'), [0:5:50]);
mean_dist = splitapply(@mean, res_table(:, 1), dist_groups);

samples = 1; 
% samples = 1:height(res_table);

line_style = ["-", ":", "-.", "--", ":"];
marker = ['x', 'o', "square", 'd', '|'];
style_counter = 0;

figure;
for i = 3:size(res_table, 2)
    if rem(i, 2) == 1
        style_counter = max(1, rem(style_counter + 1, length(line_style)));
        subplot(2, 1, 1);
        title('Communication');
        ylabel('Min Comm SINR');
    else
        subplot(2, 1, 2);
        title('Sensing');
        ylabel('Target SNR')
        xlabel('Target-Closest UE Distance (m)');
    end
    hold on;
    grid on;
    data = res_table(:, i);
    mean_val = splitapply(@mean, data, dist_groups);
    plot(mean_dist, mean_val, LineStyle=line_style(style_counter), Marker=marker(style_counter), DisplayName=legend_list{i})
end
legend;