clear; close all;

% angle x, angle y, delta x, delta y
data = csvread('../../doc/report/eye_pointing_data.csv');
sinangle = sin(data(:,1)*pi/180);
deltax = data(:,3);
[r,m,b] = regression(deltax, sinangle, 'one');
scatter(deltax, sinangle); hold on;
plot(deltax, m*deltax+b);
xlabel('delta x'); ylabel('sin \theta_x');
r