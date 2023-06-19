function total_power = calc_power(lamb, power)
% total_power = calc_power(lamb, power)
% 
% Function to calculate the integrated power of an spectrum.
%
% input:    power [mW]
%           lamb  [m]
%           resolution -> normlized wavelength window used by OSA

    resolution = 1e-9; 
    % TODO: check and confirm this resolution part.
    % If P_osa = [mW]x[nm]
    % P_peak = P_osa / resolution_osa  = [mW]x[nm]/[nm]
    % P_integrated ???

    dlamb = diff(lamb); 
    total_power = sum(power(2:end) .* dlamb / resolution);
  
end
