% Script to calculate and add the mean wavelength 
% information to each spectrum data file.
% The mean wavelength is used in the IFOG scale factor instead of the 
% peak wavelength

clc; clear; close all;

initial_path = pwd;
addpath(initial_path);
path = uigetdir();
acquisition = {'acq1_25c_200nm_24_2c\';...
               'acq2_25c_100nm_24_2c\';...
               'acq3_25c_200nm_19_5c\';...
               'acq4_25c_200nm_17_6c\'};
file_name_pattern = 'data ';
n = 39; % number of files in each folder

% for loop to access each folder
for i = 1:length(acquisition)
    cd([path,acquisition{i}])
    fprintf(['Folder ',acquisition{i},'n'])
    mean_wav_array = zeros(n,1);
    % for loop to access each spectrum
    for j = 1:n
        file = [file_name_pattern, num2str(j-1),' .lvm'];
        
        fid = fopen(file,'r');
        tmp = fscanf(fid,'%f');
        fclose(fid);

        power = [tmp(1); tmp(8:2:end)];
        wave = [tmp(2); tmp(9:2:end)];
        % Save one file for each folder with FWHM data of all measures
        mean_wav_array(j) = calc_mean_wavelength(wave, power, 1);
        
    end
    writematrix(mean_wav_array,'mean_wavelength.txt')
end

cd(initial_path)