% Script to import one lvm file containing one spectrum
% into matlab workspace

filename = 'LabVIEW Data 8 .lvm';
path = uigetdir();
initial_path = pwd;
cd(path)
data = importdata([path,'\',filename]);
cd(initial_path)