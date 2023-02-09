function F = beam_matched_filter(H)
    F = H;
    F = beam_normalization(F, 'UE');
end
     