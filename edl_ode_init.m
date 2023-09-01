function x_dot = edl_ode(t, x)
    
    % state vector x = [lon, lat, alt, vel, fpa, azi]
    phi = x(1);     % Longitude (rad)
    theta = x(2);   % Latitude (rad)
    h = x(3);       % Altitude (m)
    V = x(4);       % Velocity (m/s)
    y = x(5);       % Flight Path Angle (rad)
    psi = x(6);     % Heading Angle (rad)

    % Control Input
    sig = 0;        % Bank Angle (rad)
    
    % Mars Contants
    Rm = 3376.2 * 1000; %  Mars Radius (m)
    mu = 4.2828 * 10^13; % Mars Gravitational Parameter (m^3/s^2)
    rho0 = 0.02; % Mars Sea-Level Density kg/m^3
    H = 11.1; % Mars scale height (km)
    
    % Reentry Vehicle Constants
    m =800;        % Vehicle Mass (kg)
    Cd = 1.7;      % Vehicle Drag Coefficient
    Cd_pc = 1.1;    % Vehicle Drag Coefficient Parachute
    L_D = 0.22;     % Vehicle L/D ratio
    radius = 1.65; % Shell radius (m)
    S = (pi*radius*radius); % Shell Area (m^2)
    S_pc = 107.2;           % Parachute Area (m^2)
        
    rho = rho0 * exp(-h/H/1000);  % Atmospheric Density (kg/m^3)
    D = (1/2)*rho*V*V*S*Cd;       % Drag Force  
    L = L_D*D;                    % Lift Force
    M = V / sqrt(1.294*188.92* 148.15); % Mach Number
%     disp(M);
%     Deploy Parachute at Mach 
%     if M <= 1.5
%         
%         D = D + ((1/2)*rho*V*V*S_pc*Cd_pc);
%         L = 0;
%     end
%     disp(S)
    r = Rm + h;
    g = mu/r^2;
    phi_dot = (V/r)*cos(y)*sin(psi)/cos(theta);
    theta_dot = (V/r)*cos(y)*cos(psi);
    h_dot = V*sin(y);
    V_dot = -(D/m)-(g*sin(y));
    y_dot = (L/m/V*cos(sig))+(cos(y)*((V/r)-(g/V)));
    psi_dot = ((1/m/V/cos(y))*L*sin(sig))+((V/r/cos(theta))*cos(y)*sin(psi)*sin(theta));
    
    
    x_dot(1) = phi_dot;
    x_dot(2) = theta_dot;
    x_dot(3) = h_dot;
    x_dot(4) = V_dot;
    x_dot(5) = y_dot;
    x_dot(6) = psi_dot;
    x_dot= x_dot';

end
