% Script to calculate and add the mean wavelength 
% information to each spectrum data file.
% The mean wavelength is used in the IFOG scale factor instead of the 
% peak wavelength

clc; clear; close all;

initial_path = pwd;
addpath(initial_path);
path = ['C:\Users\User\Meu Drive\ITA\Data\10 - Gyroscope\IFOG 1550nm\SLD Superlum 761\']
acquisition = {'acq13_50_400mA_dbm_nm_18c_span_200nm\';...
               'acq6_50_400mA_dbm_nm_19c_span_200nm\';...
               'acq7_50_400mA_dbm_nm_20c_span_200nm\';...
               'acq8_50_400mA_dbm_nm_21c_span_200nm\';...
               'acq9_50_400mA_dbm_nm_22c_span_200nm\';...
               'acq10_50_400mA_dbm_nm_23c_span_200nm\';...
               'acq11_50_400mA_dbm_nm_24c_span_200nm\';...
               'acq12_50_400mA_dbm_nm_25c_span_200nm\';...
             }
file_name_pattern = 'LabVIEW Data ';
n = 40;

% for loop to access each folder
for i = 1:length(acquisition)
    cd([path,acquisition{i}])
    fprintf(['Folder ',acquisition{i},'n'])
    mean_wav_array = zeros(n,1);
    % for loop to access each spectrum
    for j = 1:n
        file = [file_name_pattern, num2str(j-1),' .lvm'];
        data = importdata(file); % [nan; power, wav]
        
        % Save one file for each folder with FWHM data of all measures
        mean_wav_array(j) = calc_mean_wavelength(data(:,3), data(:,2), 1);
        
    end
    writematrix(mean_wav_array,'mean_wavelength.txt')
end

cd(initial_path)