% Script to add calculated values to each spectrum data file

clc; clear; close all;

initial_path = pwd;
addpath(initial_path);

path = uigetdir();
cd(path);
file_name_pattern = 'data';

% get all folders inside main folder
%
%   If you do not want to run all subfolders, specify it.
%   acq = {'acq1\';'acq2\';'acq3\';'acq4\'};
%
acq = dir(path);
acq = acq(3:end); % ignoring navigation ref
acq_ind = [acq.isdir]; % logic to array
acq = acq(acq_ind);
acq = strcat({acq.name},'\') ; % to cell array

tic
% for loop to access each folder
for i = 1:length(acq)
    fprintf(['folder ',num2str(i),'\n\n'])
    cd([path,'\',acq{i}])
    
    % check if there are files inside folder
    n = length(dir([file_name_pattern,'*']));
    if n <= 0
        error("No data files found inside chosen directory!")
    end   
    
    % Initializing variables
    bw_array = zeros(n,1);
    bw_int_array = zeros(n,1);
    mean_wav_array = zeros(n,1);

    % for loop to access each spectrum
    for j = 1:n
        fprintf(['\tspectrum ',num2str(j),'\n'])
        file = [file_name_pattern, num2str(j-1),'.lvm'];
        fid = fopen(file,'r');
        tmp = fscanf(fid,'%f');
        fclose(fid);

        power = [tmp(1); tmp(8:2:end)];
        wave = [tmp(2); tmp(9:2:end)];

        % Save one file for each folder with FWHM data of all measures
        bw_array(j) = calc_fwhm(wave, power, 1);
        bw_int_array(j) = calc_bandwidth_integrated(wave, power, 1);
        mean_wav_array(j) = calc_mean_wavelength(wave, power, 1);
        
    end

    writematrix(bw_array,'fwhm_data.txt')
    writematrix(bw_int_array,'bandwidth_int_data.txt')
    writematrix(mean_wav_array,'mean_wavelength_data.txt')

end
toc
cd(initial_path)