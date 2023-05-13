clear;
clc;
NUM = 50;  % Number of Points

% state vector x = [lon, lat, alt, vel, fpa, azi]
%% Constraints
A = [];
b = [];
Aeq = [];
Beq = [];
%   bounds =  [sim_time, lon, lat, alt, vel, fpa, azi, bank];
lb = [100; -pi*ones(NUM,1); -(pi/2)*ones(NUM,1); 0*ones(NUM,1); 100*ones(NUM,1); -(pi/2)*ones(NUM,1); -(pi/2)*ones(NUM,1); -(pi/2)*ones(NUM,1)];
ub = [2000; pi*ones(NUM,1); (pi/2)*ones(NUM,1); 15e4*ones(NUM,1); 7000*ones(NUM,1); (pi/2)*ones(NUM,1); (pi/2)*ones(NUM,1); (pi/2)*ones(NUM,1)];
load IC.mat;
% Options for fmincon
options = optimoptions(@fmincon, 'TolFun', 0.001, 'MaxIter', 10000, 'MaxFunEvals', 400000, 'Display', 'iter', 'DiffMinChange', 0.001, 'Algorithm', 'sqp');

% Solve for the best simulation time + control input
optimal = fmincon(@objective_func, x0, A, b, Aeq, Beq, lb, ub, @constraint_func, options);

save optimal