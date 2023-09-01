function cost = objective_func(x)
       
    sim_time = x(1);
    NUM = 50;
    delta_time = sim_time/NUM;
    % state vector x = [lon; lat; alt; vel; fpa; azi]
    lons = x(2      : 1 + NUM);
    lats = x(2 + NUM*1: 1 + NUM*2);
    alts = x(2 + NUM*2: 1 + NUM*3);
    vels = x(2 + NUM*3: 1 + NUM*4);
    fpas = x(2 + NUM*4: 1 + NUM*5);
    azis = x(2 + NUM*5: 1 + NUM*6);
    bnks = x(2 + NUM*6: 1 + NUM*7);
    
    ind = 1:49; 
    acc = abs((vels(ind+1)-vels(ind))/delta_time);
    acc = max(acc);
    cost = acc;    
end