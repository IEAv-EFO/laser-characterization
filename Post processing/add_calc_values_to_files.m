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

% check if folder is data folder itself
if isempty(acq) == 1
    acq = 1;
end

tic
% for loop to access each folder
for i = 1:length(acq)
    fprintf(['folder ',num2str(i),'\n\n'])
    
    if acq == 1
        cd(path)
    else
        cd([path,'\',acq{i}])
    end
    
    % check if there are files inside folder
    n = length(dir([file_name_pattern,'*']));
    if n <= 0
        error("No data files found inside chosen directory!")
    end   
    
    % Initializing variables
    calculated_data = zeros(n,5);
        
    % for loop to access each spectrum
    for j = 1:n
        fprintf(['\tspectrum ',num2str(j),'\n'])
        file = [file_name_pattern, num2str(j-1),'.lvm'];
        fid = fopen(file,'r');
        tmp = fscanf(fid,'%f');
        fclose(fid);

        power_raw = [tmp(1); tmp(8:2:end)];
        wave_raw = [tmp(2); tmp(9:2:end)];

        % Creating data array
        [wave, power] = normalize_osa(wave_raw, power_raw);
        power = dbm2mw(power);
        
        calculated_data(j,:) = [calc_power(wave, power),...
               calc_fwhm(wave, power, 0),...
               calc_bandwidth_integrated(wave, power),...
               calc_mean_wavelength(wave, power),...
               tmp(3)];

    end
    
    % Save calculated values and metadata
    metadata = {'Integrated Power' 'FWHM' 'Integrated bandwidth'...
        'Mean wavelength' 'Pump Current ILX'};
    output = [metadata; num2cell(calculated_data)];
    writecell(output, 'calculated_data.csv')    

end
toc
cd(initial_path)