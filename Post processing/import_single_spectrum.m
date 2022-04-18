% Script to import one lvm file containing one spectrum
% into matlab workspace

filename = 'LabVIEW Data 8 .lvm'
path = 'C:\Users\User\Meu Drive\ITA\Data\2 - Laser diode characterization\data\acquisition3_50mA-650mA_50mAstep'
% path = 'C:\Users\User\Meu Drive\ITA\Data\10 - Gyroscope\IFOG 1550nm\2022_04_12\acq7_50_400mA_dbm_nm_20c_span_200nm';
initial_path = pwd;
cd(path)
data = importdata([path,'\',filename]);
cd(initial_path)