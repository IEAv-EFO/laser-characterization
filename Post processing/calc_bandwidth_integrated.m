function fwhm = calc_fwhm_integrated(x,y,db)
% Function to calculate the FWHM of a given spectrum given in dBm.
%
% This function takes into consideration the double-peaked shape of the
% erbium broadband emission. The 3-dB FWHM won't work in this case, so the
% appropriate definition is weighted by the square of the power.
%
% fwhm = calc_fwhm_integrated(x,y,db)
% 
% db = 1 --> measurement in dBm
% db = 0 --> measurement in mW
    
    if db == 1
        y = 10.^((y)/10); % [mW]
    end
    
    dx = diff(x);
    
    fwhm = (sum(y(1:end-1).*dx))^2/...
               sum((y(1:end-1).^2).*dx);

end
