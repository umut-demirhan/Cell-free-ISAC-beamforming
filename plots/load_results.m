function [res_table, legend_list] = load_results(folder, selection_tag)
%LOAD_RESULTS Summary of this function goes here
%   Detailed explanation goes here

    folder = dir(folder);
    files = {folder.name};
    files = files(3:end);
    res_table = [];
    for file_idx=1:length(files)
        filename = files{file_idx};
        if contains(filename, selection_tag)
            load(fullfile(folder(1).folder, filename));
            num_samples = length(results);
            res_mat = zeros(1, num_samples);
            table_headers = {};
            num_power = length(results{1}.power);
            for rep = 1:(num_samples*num_power)
                res_idx = ceil(rep/num_power);
                col = 1;
                % Min Distance
                [~, distance] = compute_angle_dist(results{res_idx}.UE, results{res_idx}.Target);
                res_mat(col, rep) = min(distance);
                table_headers{col} = 'Min UE-Target Distance';
                col = col + 1;
                table_headers{col} = 'Power-ratio';
                p_i = mod(rep, num_power);
                if p_i == 0
                    p_i = num_power;
                end
                res_mat(col, rep) = params.P_comm_ratio(p_i);

                for sol = 1:length(results{1}.power{1})
                    col = col + 1;
                    res_mat(col, rep) = results{res_idx}.power{p_i}{sol}.min_SINR;
                    table_headers{col} = strcat(results{res_idx}.power{p_i}{sol}.name, '-Comm');
                    col = col + 1;
                    res_mat(col, rep) = results{res_idx}.power{p_i}{sol}.SSNR;
                    table_headers{col} = strcat(results{res_idx}.power{p_i}{sol}.name, '-Sensing');
                end
            end
            res_table = [res_table; array2table(res_mat.', 'VariableNames', table_headers)];
            legend_list = table_headers;
        end
    end
end

