function [metric_struct] = compute_metrics(H_comm, F_comm, sigmasq_ue, sensing_beamsteering, F_sensing, sigmasq_radar_rcs)
    % metric_struct.F_comm = F_comm;
    % metric_struct.F_sensing = F_sensing;
    metric_struct.power = compute_power(F_comm) + compute_power(F_sensing);
    metric_struct.SINR = compute_SINR(H_comm, F_comm, F_sensing, sigmasq_ue);
    metric_struct.min_SINR = min(metric_struct.SINR);
    metric_struct.SSNR = compute_sensing_SNR(sigmasq_radar_rcs, sensing_beamsteering, F_comm, F_sensing);
end

