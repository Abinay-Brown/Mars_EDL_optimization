sim_time = optimal(1);
NUM = 50;
delta_time = sim_time/NUM;
% state vector optimal = [lon; lat; alt; vel; fpa; azi]
lons = optimal(2      : 1 + NUM)*(180/pi);
lats = optimal(2 + NUM*1: 1 + NUM*2)*(180/pi);
alts = optimal(2 + NUM*2: 1 + NUM*3);
vels = optimal(2 + NUM*3: 1 + NUM*4);
fpas = optimal(2 + NUM*4: 1 + NUM*5);
azis = optimal(2 + NUM*5: 1 + NUM*6);
bnks = optimal(2 + NUM*6: 1 + NUM*7)*(180/pi);
figure(1);
scatter3(lons, lats, alts/1000,'.');
xlabel('Longitude (deg)');
ylabel('Latitude (deg)');
zlabel('Altitude (km)');
axis square;
format longg

figure(2);
t = linspace(0, sim_time, 50);
plot(t, bnks);
xlabel('time (sec)')
ylabel('Bank Angle \sigma (deg)');
grid on;
axis square;