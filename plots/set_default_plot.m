%% Default Plot Settings
set(0,'defaultLineLineWidth', 2)
set(0,'defaultAxesFontSize',12)
set(0,'defaultAxesFontName','Arial')
set(0,'defaultAxesLineWidth', 1)
figure_size = 460;
figure_x = figure_size*(1+sqrt(5)) / 4;
figure_y = figure_size / 2;
pixel = get(0,'screensize');
middle_x = pixel(3)/2;
middle_y = pixel(4)/2;
set(0,'defaultFigurePosition', [middle_x-figure_x middle_y-figure_y figure_x*2 figure_y*2]);
set(groot,'DefaultAxesColororder', 'default');
clear figure_size figure_x figure_y pixel middle_x middle_y