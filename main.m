clear; clc;close;
state0 = [deg2rad(0), deg2rad(0), 125*1000, 7.3*1000, -13*(pi/180),  0*(pi/180)];
t = [0, 40*60];
options = odeset('RelTol',1e-12, 'AbsTol',1e-12);
[t1,r1] = ode45(@edl_ode, t, state0, options);
r1 = r1(r1(:,3)>0, :);
scatter3(rad2deg(r1(:,1)), rad2deg(r1(:,2)), r1(:,3)/1000,'.');
xlabel('Longitude (deg)');
ylabel('Latitude (deg)');
zlabel('Altitude (km)');
format longg

disp(r1(end, :))
axis square
