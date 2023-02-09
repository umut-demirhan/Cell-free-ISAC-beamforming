cvx_path = 'C:\Users\umt\Desktop\cvx'; % Path of the CVX installation
addpath(genpath(cvx_path)); % Add CVX to the path
addpath(genpath('./')); % Add paths of subfolders



%% Simulation for Fig. 3
clear all;
eval('sim_params'); % load the parameters
output_file = 'power_data';
simulation(params, output_file);
plot_results_power;

%% Simulation for Fig. 4
clear all;
eval('sim_params'); % load the parameters
params.P_comm_ratio = [0.5]; % Fixed power ratio for communications

% Generate samples with a pre-determined range of
% minimum distance between the target and closest UE
for min_dist = 0:5:45   
    params.geo.min_dist = min_dist;
    params.geo.max_dist = min_dist+5;
    
    output_file = strcat('dist_data', num2str(min_dist));
    simulation(params, output_file);
end
plot_results_dist;