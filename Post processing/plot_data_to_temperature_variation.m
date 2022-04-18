clc
clear
close all

initial_path = pwd;
path = 'C:\Users\User\Meu Drive\ITA\Data\10 - Gyroscope\IFOG 1550nm\2022_04_12\'
acquisition = {'acq13_50_400mA_dbm_nm_18c_span_200nm\';...
               'acq6_50_400mA_dbm_nm_19c_span_200nm\';...
               'acq7_50_400mA_dbm_nm_20c_span_200nm\';...
               'acq8_50_400mA_dbm_nm_21c_span_200nm\';...
               'acq9_50_400mA_dbm_nm_22c_span_200nm\';...
               'acq10_50_400mA_dbm_nm_23c_span_200nm\';...
               'acq11_50_400mA_dbm_nm_24c_span_200nm\';...
               'acq12_50_400mA_dbm_nm_25c_span_200nm\';...
             }

file1 = 'Power vs Current .lvm';
file2 = 'Power vs Wavelength .lvm';

figure(1); hold on;
figure(2); hold on;
figure(3); hold on;
for i =1:length(acquisition)
% Check if power values are given in dBm or in dBm/nm
    cd([path,acquisition{i}])
    power_current = importdata(file1); 
    power_wave = importdata(file2); 
    
    leg = ['Temp = ', num2str(i+17)];

    % Current by Optical power in dBm/nm
    figure(1)
    plot(power_current(:,2), power_current(:,3),'DisplayName', leg)
        xlabel('Current [mA]')
        ylabel('Optical Power [dBm/nm]')
    
    % Optical power in dBm/nm by Wavelength
    figure(2)
    plot(power_wave(:,2), power_wave(:,3),'DisplayName', leg)
        xlabel('Optical Power [dBm/nm]')
        ylabel('Wavelength [nm]')
    
    % Current by Optical power in mW
    fwhm = 44; % calculate this value with calc_fwhm(x,y,db)
    mW = 10.^((power_current(:,3))./10)*fwhm;

    figure(3)
    plot(power_current(:,2), mW,'DisplayName', leg)
        xlabel('Current [mA]')
        ylabel('Optical Power [mW]')
end

figure(1);   legend show
figure(2);   legend show
figure(3);   legend show
cd(initial_path)