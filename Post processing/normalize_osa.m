function [normalized_lamb, normalized_power] = normalize_osa(lamb, power)
% normalized_power = osa_normalize(lamb, power)
% 
% Function to normalize spectrum from Advantest Optical Spectrum Analizer.
% The OSA provides the area of power vs. delta lambda
%
% input:    power [mW]
%           lamb  [m]

    normalized_power = power(2:end) - 10*log10( diff(lamb)*1e9 );
    normalized_lamb = lamb(2:end);
end
