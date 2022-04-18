clc
clear

% Paths
initial_path = pwd;
dir = uigetdir();
cd(dir)


% Check if power values are given in dBm or in dBm/nm
power_current = importdata('Power vs Current .lvm'); 
power_wave = importdata('Power vs Wavelength .lvm'); 

figure
plot(power_current(:,2), power_current(:,3))
    xlabel('Current [mA]')
    ylabel('Optical Power [dBm/nm]')
%     set(gca, 'YScale', 'log')
figure
plot(power_wave(:,2), power_wave(:,3))
    xlabel('Optical Power [dBm/nm]')
    ylabel('Wavelength [nm]')

%%
cd(initial_path)