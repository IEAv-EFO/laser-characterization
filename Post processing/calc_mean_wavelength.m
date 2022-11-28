function mean_wav = calc_mean_wavelength(lamb, power, db)
% Function to calculate the mean Wavelength of an spectrum.
%
% mean_wav = calc_mean_wav(lamb,power)
% db = 1 --> dBm or dBm/nm
% db = 0 --> mW
    
    if db == 1
        power = 10.^((power)/10); % [mW]
    end
    dlamb = diff(lamb);
    
    mean_wav = sum(power(1:end-1).*lamb(1:end-1).*dlamb)/...
               sum(power(1:end-1).*dlamb);

end