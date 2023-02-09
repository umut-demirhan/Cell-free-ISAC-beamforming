%% Parameters
params.N_t = 16; % Number of antennas per AP
params.M_t = 2; % Number of APs
params.U = 5; % Number of users
params.T = 1; % Number of targets

params.P = 1; % Power per AP (W)
params.P_comm_ratio = [0.01, 0.1, 0.25, 0.5, 0.75, 0.9, 0.99]; % Power ratio for communications % [0.5];

% Bisection Limits (if needed)
params.bisect.low = 0.01;
params.bisect.high = 60;
params.bisect.tol = 1e-2;

% Noise
params.sigmasq_ue = 1; % UE receiver noise
params.sigmasq_radar_rcs = 0.1; % Radar RCS variable 
params.sigmasq_radar_receiver = 1; % Radar receiver noise

params.repetitions = 1000;

% Geometry setup
params.geo.line_length = 100;
params.geo.UE_y = 50;
params.geo.target_y = 50;
params.geo.min_dist = 0;
params.geo.max_dist = params.geo.line_length;