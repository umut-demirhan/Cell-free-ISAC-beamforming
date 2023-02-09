function [F] = beam_normalization(F, type)
    [A, B, C] = size(F);
    if type == 'AP'
        norm = sum(abs(F).^2, [1, 3]);
        norm = reshape(norm, 1, B, 1);
    elseif type == 'UE'
        norm = sum(abs(F).^2, 3);
        norm = reshape(norm, A, B, 1)*(A); % Power for each AP-UE pair needs to be 1/UE thus multiplied by A
    else
        error('Beam normalization type is not defined!');
    end

    F = F ./ sqrt(norm);
end

