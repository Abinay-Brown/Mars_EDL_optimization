clear; clc;close;
state0 = [-1.472993311, 0.5894954268, 125*1000, 7.3*1000, -15*(pi/180),  0*(pi/180)];
sim_time = 510;
NUM = 50;
t = linspace(0, sim_time, NUM);
options = odeset('RelTol',1e-12, 'AbsTol',1e-12);
[t1,r1] = ode45(@edl_ode_init, t, state0, options);
r1 = r1(r1(:,3)>0, :);
scatter3(rad2deg(r1(:,1)), rad2deg(r1(:,2)), r1(:,3)/1000,'.');
xlabel('Longitude (deg)');
ylabel('Latitude (deg)');
zlabel('Altitude (km)');
format longg

disp(r1(end, :))
axis square
x0 = [sim_time; r1(:,1); r1(:,2); r1(:,3); r1(:,4); r1(:,5); r1(:,6); zeros(50, 1)];
save('IC.mat', "x0");