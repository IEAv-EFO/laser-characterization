% This program collects all the spectrum data in the folder in one 3D array
% and plots all the spectrums.
clear; close all; clc
set(groot,'defaultAxesTickLabelInterpreter','latex')
set(groot,'defaultLegendInterpreter','latex')
belize = [41, 128, 185]/255;
pumpkin = [211, 84, 0]/255;


% Folder management
initial_path = pwd;
path = uigetdir();
cd(path)
file_pattern = 'data';

extension = '.lvm';
N = length(dir([file_pattern, '*']));
tic

% Importing data
for i=1:N
    file = [file_pattern num2str(i-1) extension];

    fid = fopen(file,'r');
    tmp = fscanf(fid,'%f');
    fclose(fid);
    
    if i == 1
        data_size = length([tmp(2); tmp(9:2:end)]); 
        power = zeros(data_size, N);
        wave = zeros(data_size, N);
        current = zeros(data_size, N);
    end

    power(:,i) = [tmp(1); tmp(8:2:end)];     % dBm
    wave(:,i) = [tmp(2); tmp(9:2:end)];      % m     
    current(:,i) = tmp(3);                   % mA
end
%% 2D plot
figure
hold on
    plot(wave, power,'color',[.6 .6 .6])
    h1 = plot(wave(:,1), power(:,1), 'color', belize);
    h2 = plot(wave(:,end), power(:,end), 'color', pumpkin);
        xlim([wave(1,1), wave(end,1)])
        leg1 = sprintf('%.0f mA', current(1,1));
        leg2 = sprintf('%.0f mA', current(1,end));
        legend([h1, h2], leg1, leg2)
        xlabel('Wavelength [m]','interpreter','latex','FontSize',12)
        ylabel('Optical power [dBm]','interpreter','latex','FontSize',12)

saveas(figure(1),'2d_plot.png')

%% 3D plot   
figure('Units','centimeter','Position',[10 10 30 12],'PaperPositionMode','auto')
    X = squeeze(wave);
    Y = squeeze(power);
    Z = current;
    mesh(X,Y,Z)
        view([-20,20,-45])
        camup([0 1 0]);
        set(gca,'Xdir','reverse')
        xlabel('Wavelength [m]','interpreter','latex','FontSize',12)
        ylabel('Optical power [dBm]','interpreter','latex','FontSize',12)
        zlabel('Pump current [mA]','interpreter','latex','FontSize',12)
        fig1=figure(1);

%%
cd(initial_path)
toc