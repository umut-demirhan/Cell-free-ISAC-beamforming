function sensing_SNR = compute_sensing_SNR(sigmasq_radar_rcs, sensing_beamsteering, F_comm, F_sensing)
    % [T, M_t, N_t] = size(sensing_beamsteering);
    stacked_beams_streams = cat(1, F_comm, F_sensing); % Streams x M x N
    beam_gain = stacked_beams_streams.*conj(sensing_beamsteering); % a(\theta_{m_t, n_t}) * conj(f_{m_t, s, n_t}) for each element
    % The output is streams x M_t x N_t
    per_beam_per_ap_gain = abs(sum(beam_gain, 3)).^2; % ||a(\theta_{m_t} f_{m_t, s}||^2
    sensing_tx_gain = sum(per_beam_per_ap_gain, 'all'); % Sum over streams and M_t
    sensing_SNR = sensing_tx_gain*sigmasq_radar_rcs; % Scale with sensing gain
end