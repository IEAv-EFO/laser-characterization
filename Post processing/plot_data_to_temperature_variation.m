clc
clear
close all

initial_path = pwd;
path = uigetdir();
acquisition = {'acq13_50_400mA_dbm_nm_18c_span_200nm\';...
               'acq6_50_400mA_dbm_nm_19c_span_200nm\';...
               'acq7_50_400mA_dbm_nm_20c_span_200nm\';...
               'acq8_50_400mA_dbm_nm_21c_span_200nm\';...
               'acq9_50_400mA_dbm_nm_22c_span_200nm\';...
               'acq10_50_400mA_dbm_nm_23c_span_200nm\';...
               'acq11_50_400mA_dbm_nm_24c_span_200nm\';...
               'acq12_50_400mA_dbm_nm_25c_span_200nm\';...
             }

for num_fig = 1:7
    figure(num_fig); hold on;
end

for i =1:length(acquisition)
% Check if power values are given in dBm or in dBm/nm
    cd([path,acquisition{i}])
    power_current = importdata('Power vs Current .lvm'); 
    power_wave = importdata('Power vs Wavelength .lvm'); 
    fwhm = importdata('fwhm_data.txt');

    leg = ['Temp = ', num2str(i+17)];

    mW = 10.^((power_current(:,3))/10).*(fwhm*1e9);

    % Current by Optical power in dBm/nm
%     figure(1)
%     plot(power_current(:,2), power_current(:,3),'DisplayName', leg)
%         xlabel('Current [mA]')
%         ylabel('Optical Power [dBm/nm]')
%     
%     % Optical power in dBm/nm by Wavelength
%     figure(2)
%     plot(power_wave(:,2), power_wave(:,3),'DisplayName', leg)
%         xlabel('Optical Power [dBm/nm]')
%         ylabel('Wavelength [nm]')
%     
%    % Optical power [mW] by Wavelength
%     figure(3)
%     plot(mW, power_wave(:,3),'DisplayName', leg)
%         xlabel('Optical Power [mW]')
%         ylabel('Wavelength [nm]')
% 
%     % Current by Optical power in mW
%     figure(4)
%     plot(power_current(:,2), mW,'DisplayName', leg)
%         xlabel('Current [mA]')
%         ylabel('Optical Power [mW]')
    
    % Optical power [mW] by linewidth
    figure(5)
    plot(mW, fwhm*1e9,'DisplayName', leg)
        xlabel('Optical Power [mW]')
        ylabel('Bandwidth [nm]')

end

figure(1);   legend('show','Location','best')
figure(2);   legend('show','Location','best')
figure(3);   legend('show','Location','best')
figure(4);   legend('show','Location','best')

cd(initial_path)