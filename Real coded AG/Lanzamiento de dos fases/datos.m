function [v,t,h,a]=datos(mc1,mc2)
    % This function calculates the trajectory of a two-stage
    % launcher with fuel masses mc1 and mc2.
    % Inputs:
    % mc1, mc2: fuel masses of stages 1 and 2 respectively.
    % Outputs:
    % v: velocity of the launcher during the mission
    % t: time of the mission
    % h: height of the launcher during the mission
    % a: aceleration of the launcher during the mission
    
    t1=mc1/10000; % Duration of the first stage
    t2=mc2/2000; % Duration of the second stange

    dt=0.1; % Orientative discretization
    
    k1=round(t1/dt); 
    k2=round(t2/dt); 
    t=zeros(1,k1+k2+1);
    v=zeros(1,k1+k2+1);
  
    h=zeros(1,k1+k2+1);
    a=zeros(1,k1+k2+1);
    
    dt1=t1/k1; % 1st stage time discretization
    dt2=t2/k2; % 2nd stage time discretization
    
    R=6371000.7900; % Earth radius
    g=9.80665; % gravity of earth
    
    h(1)=0; % Initial heigh above the sea level
    v(1)=0; % Initial velocity
    t(1)=0; % Initial time
    
    m0=2.5*10^6; % Launcher's initial mass
    
    for i=1:k1
       t(i+1)=t(i)+dt1;
       F=50*10^6-0.5*1.2*35*((v(i))^2)*exp(-0.00011856*h(i))-g*m0*(R/(R+h(i)))^2;
       m1=m0-dt1*10000;
       a(i)=F/m0;
       v(i+1)=v(i)+a(i)*dt1;
       h(i+1)=h(i)+v(i)*dt1+0.5*a(i)*dt1^2;
       m0=m1;
    end
    
    m0=m0-10^6;  % Launcher's mass at the end of the 2st stage.

    for i=(k1+1):(k1+k2)
       t(i+1)=t(i)+dt2;
       F=14*10^6-0.5*1.2*10*((v(i))^2)*exp(-0.00011856*h(i))-g*m0*(R/(R+h(i)))^2;
       m1=m0-dt2*2000;
       a(i)=F/m0;
       v(i+1)=v(i)+a(i)*dt2;
       h(i+1)=h(i)+v(i)*dt2+0.5*a(i)*dt2^2;
       m0=m1;
    end

end