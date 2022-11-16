% Script to add FWHM information to each spectrum data file

clc; clear; close all;

initial_path = pwd;
addpath(initial_path);

path = uigetdir();
acquisition = {'acq1_25c_200nm_24_2c\';'acq2_25c_100nm_24_2c\'};
file_name_pattern = 'data ';

cd([path,acquisition{1}])
n = length(dir([file_name_pattern,'*']));

tic
% for loop to access each folder
for i = 1:length(acquisition)
    fprintf(['i=',num2str(i),'\n\n'])
    cd([path,acquisition{i}])
    
    bw_array = zeros(n,1);
    % for loop to access each spectrum
    for j = 1:n
        fprintf(['j=',num2str(j),'\n'])
        
        file = [file_name_pattern, num2str(j-1),' .lvm'];
        fid = fopen(file,'r');
        tmp = fscanf(fid,'%f');
        fclose(fid);

        power = [tmp(1); tmp(8:2:end)];
        wave = [tmp(2); tmp(9:2:end)];

        % Save one file for each folder with FWHM data of all measures
        bw_array(j) = calc_fwhm(wave, power, 1);
        
    end
    writematrix(bw_array,'fwhm_data.txt')
end
toc
cd(initial_path)