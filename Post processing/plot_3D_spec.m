% This program collects all the spectrum data in the folder in one 3D array
% and plots all the spectrums.
clear all
close all
clc
set(groot,'defaultAxesTickLabelInterpreter','latex')
set(groot,'defaultLegendInterpreter','latex')

dir = uigetdir('D:\Users\Stinky\Google Drive Academic\ITA\Data\10 - Gyroscope');
addpath(dir)
extension = '.lvm';

N = input('Qual o numero do ultimo arquivo na pasta?   R:');

tempData = importdata('LabVIEW Data 0 .lvm');
tempData = tempData(:,2:end);
y = tempData(:,1); %dBm
x = tempData(:,2); %mx
current = tempData(1,3); %mA
z = ones(length(x),1);
tempMatrix = zeros(0,N);

for i=1:N+1
    file = ['LabVIEW Data',' ',num2str(i-1),' ',extension];
    tempData = importdata(file);
    tempData = tempData(:,2:end);
    y = tempData(:,1); %dBm
    x = tempData(:,2); %m
    current = tempData(1,3); %mA
    Data(:,:,i) = [tempData(:,2),tempData(:,1)];
    z(:,i) = current;
end

figure('Units','centimeter','Position',[10 10 30 12],'PaperPositionMode','auto')
    X = squeeze(Data(:,1,:));
    Y = squeeze(Data(:,2,:));
    Z = z;
    mesh(X,Y,Z)
        view([-20,20,-45])
        camup([0 1 0]);
        set(gca,'Xdir','reverse')
        xlabel('Wavelength [m]','interpreter','latex','FontSize',12)
        ylabel('Optical power [dBm/nm]','interpreter','latex','FontSize',12)
        zlabel('Pump current [mA]','interpreter','latex','FontSize',12)
        fig1=figure(1);
        fig1.Renderer='Painters';

