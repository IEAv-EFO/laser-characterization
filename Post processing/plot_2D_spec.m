% Script to plot spectra from Advantest OSA acquired with LabVIEW.
% This script is used to take all .lvm files inside a folder 
% and plot each individual optical spectrum in a different plot.

% Initial config
clear all
clc
set(groot,'defaultAxesTickLabelInterpreter','latex')
set(groot,'defaultLegendInterpreter','latex')
gratio = (1+sqrt(5))/2;
height = 7; % cm

% Path
disp('Choose the file path where the waveforms are:')
selpath = uigetdir
while selpath == 0
    selpath = uigetdir;  % wait path selection by user
end
cd(selpath)

files = dir('*.lvm');
if length(files)<=0
    disp('No .lvm files were found in this directory')
end
files = struct2table(files);
files = files(:,1);
files = table2array(files);

path = [selpath,'\'];
color = [0.3, 0.3, 0.3]; 

% Plotting
N = length(files)-2;
for i = 1:N
    filename = files{i};
    
    data{i} = importdata(filename);
    y(:,i) = data{i}(:,2); % dBm or dBm/nm
    x(:,i) = data{i}(:,3); % m
    current(i) = data{i}(1,4); % mA
    peak(i) = data{i}(1,5);
    power(i) = data{i}(1,6);
    
    figure('Name', [filename(1:end-4), '_spec'],...
        'units','centimeter','position',[1 1 height*gratio height]);
    plot(x(:,i),y(:,i),'color',color)
        xlabel('Wavelength [m]','interpreter','latex')
        ylabel('Optical power [dBm]','interpreter','latex')
        xlim([x(1,i) x(end,i)])
        ylim([min(y(1,i))-5 max(y(:,i))+5])
        grid minor
end