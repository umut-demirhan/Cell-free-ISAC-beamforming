%% 2D Beamsteering function
%
% Inputs are in the shape of beamsteering(theta, num_ant, %optional% lambda)
%
% theta is the angle in radians, can be of any shape
%
% lambda is a ratio of antenna spacing
% Default value is 1/2 corresponding to lambda/2 antenna spacing
%
% Returns beamsteering vector a(theta) expanded into the last dimension
% The output has the shape (size(theta) x num_ant)
%
function [a_theta] = beamsteering(varargin) 
    
    if nargin == 2
        theta = varargin{1};
        num_ant = varargin{2};
    end
    if nargin > 2
        lambda = varargin{3};
    else
        lambda = 1/2;
    end
    
    dim = length(size(theta));
    k = reshape([0:num_ant-1], [ones(1, dim), num_ant]);
    
    a_theta = exp(1j*2*pi*lambda*k.*cos(theta));
    
end

