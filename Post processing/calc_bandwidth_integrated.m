function fwhm = calc_bandwidth_integrated(x,y)
% fwhm = calc_fwhm_integrated(x,y,db)
%
% Function to calculate the FWHM of a given spectrum given in dBm.
%
% This function takes into consideration the double-peaked shape of the
% erbium broadband emission. The 3-dB FWHM won't work in this case, so the
% appropriate definition is weighted by the square of the power.
    
    dx = diff(x);
    
    fwhm = (sum(y(1:end-1).*dx))^2/...
               sum((y(1:end-1).^2).*dx);
    
end
