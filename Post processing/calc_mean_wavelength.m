function mean_wav = calc_mean_wavelength(lamb, power)
% mean_wav = calc_mean_wav(lamb,power)
%
% Function to calculate the mean Wavelength of an spectrum.

    dlamb = diff(lamb);
    
    mean_wav = sum(power(1:end-1).*lamb(1:end-1).*dlamb)/...
               sum(power(1:end-1).*dlamb);

end