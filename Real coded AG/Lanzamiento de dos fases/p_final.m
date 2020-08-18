function pf=p_final(mc1,mc2)
    % This function calculates the final lineal momemtum of a two-stage
    % launcher with fuel masses mc1 and mc2. If its performance is
    % nsenseless it will be 0.
    % Inputs:
    % mc1, mc2: fuel masses of stages 1 and 2 respectively.
    % Outputs:
    % pf: final lineal momemtum.
    
    t1=mc1/10000; % Duration of the first stage
    t2=mc2/2000; % Duration of the second stange

    dt=0.1; % Orientative discretization
    
    k1=round(t1/dt); 
    k2=round(t2/dt); 
    v=zeros(1,k1+k2+1);
    h=zeros(1,k1+k2+1);
    a=zeros(1,k1+k2+1);
    
    dt1=t1/k1; % 1st stage time discretization
    dt2=t2/k2; % 2nd stage time discretization
    
    R=6371000.7900; % Earth radius
    g=9.80665; % gravity of earth
    
    h(1)=0; % Initial heigh above the sea level
    v(1)=0; % Initial velocity
    
    m0=2.5*10^6; % Launcher's initial mass
    mf1=2.5*10^6-10^6-mc1;
    mf2=2.5*10^6-10^6-mc1-mc2;
    F1=50*10^6-0.5*1.2*35*((v(1))^2)*exp(-0.00011856*h(1))-g*m0*(R/(R+h(1)))^2;
    if mf1<1000 || mf1<mc2 || mf2<1000 || F1<=0
        pf=0;
    else
    
        for i=1:k1
            F=50*10^6-0.5*1.2*35*((v(i))^2)*exp(-0.00011856*h(i))-g*m0*(R/(R+h(i)))^2;
            m1=m0-dt1*10000;
            a(i)=F/m0;
            v(i+1)=v(i)+a(i)*dt1;
            h(i+1)=h(i)+v(i)*dt1+0.5*a(i)*dt1^2;
            m0=m1;
        end
    
        m0=m0-10^6; % Launcher's mass at the end of the 1st stage.
        if k1>0
            F2=14*10^6-0.5*1.2*10*((v(i+1))^2)*exp(-0.00011856*h(i+1))-g*m0*(R/(R+h(i+1)))^2;
        else
            F2=14*10^6-0.5*1.2*10*((v(1))^2)*exp(-0.00011856*h(1))-g*m0*(R/(R+h(1)))^2;
        end
        
        if F2<=0
            pf=0;
        else
            for i=(k1+1):(k1+k2)
                F=14*10^6-0.5*1.2*10*((v(i))^2)*exp(-0.00011856*h(i))-g*m0*(R/(R+h(i)))^2;
                m1=m0-dt2*2000;
                a(i)=F/m0;
                v(i+1)=v(i)+a(i)*dt1;
                h(i+1)=h(i)+v(i)*dt1+0.5*a(i)*dt1^2;
                m0=m1;
            end
            pf=v(k1+k2+1)*mf2;
        end
  
    end
end