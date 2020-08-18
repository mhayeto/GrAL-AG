function [v,t,h,x,an,a,Fa,Fn,m,k,k1,k2,k3,k_final]=datos_LEO_fd(ta,tp,app)
    % This function calculates the trajectory of the launcher model based
    % in the Ariane 5 model in the mission of a LEO orbit and in the next
    % seconds during the free drift.
    % Inputs:
    % ta: first maneuvre time
    % tp: second maneuvre time
    % app: second maneuvre angle
    % Outputs: 
    % v: velocity of the launcher during the mission
    % t: time of the mission
    % h: height of the launcher during the mission
    % x: Desplacement of the launcher during the mission in the X axis.
    % an:angle of the launcher during the mission
    % a: aceleration of the launcher during the mission
    % Fa: Tangential force of the launcher during the mission
    % Fn: Normal force of the launcher during the mission
    % m: mass of the launcher during the mission
    % k, k1, k2, k3, k_final: discretization values
    
    dt=0.01; 

    tb=129; % boosters time
    t3=589; % H15 time
    t4=1100; % Aestus time
    Ttot=t3+t4; % Mission time
    t_extra=1000; % Free drift time

    k=Ttot/dt+1;
    k1=tb/dt;
    k2=t3/dt;
    k3=(t3+t4)/dt;
    wk=(app-90)/tp;
    k_final=(Ttot+t_extra)/dt+1;
    
    t=zeros(1,k_final); 
    v=zeros(1,k_final); 
    h=zeros(1,k_final); 
    a=zeros(1,k_final); 
    x=zeros(1,k_final); 
    an=zeros(1,k_final); 
    Fa=zeros(1,k_final); 
    Fn=zeros(1,k_final); 
    m=zeros(1,k_final); 
    
    R=6371000.7900; % Earth radius
    g=9.80665; % Gravit of the earth
    
    
    h(1)=0; 
    v(1)=0; 
    t(1)=0;
    x(1)=0;
    an(1)=90;
    
    m(1)=761910; 
    FH15=1.118*10^6;
    FP238=6.05*10^6;
    FAestus=27540;
    mH15=15000;
    mP238=4000;
    tasaH15=263;
    tasaP238=2147;
    tasaAestus=8.1;
    Aef1=50;
    Aef2=30;
    Aef3=10;
    for i=1:k1 % H158 and 2xP238
        t(i+1)=dt*i;
        m(i+1)=m(i)-dt*(tasaH15+2*tasaP238);
        if t(i+1)<=ta % Vertical ascent
            Fa(i)=FH15+2*FP238-0.5*1.225*Aef1*((v(i))^2)*exp(-0.00011856*h(i))-g*m(i)*(R/(R+h(i)))^2;
            a(i)=Fa(i)/m(i);
            v(i+1)=v(i)+a(i)*dt;
            h(i+1)=h(i)+v(i)*dt+0.5*a(i)*dt^2;
            an(i+1)=90;            
        elseif t(i+1)<=tp+ta % Pitch push
            Fa(i)=FH15+2*FP238-0.5*1.225*Aef1*((v(i))^2)*exp(-0.00011856*h(i))-(g*m(i)*(R/(R+h(i)))^2-(m(i)*(v(i)*cosd(an(i)))^2)/(R+h(i)))*sind(an(i));
            a(i)=Fa(i)/m(i);
            v(i+1)=(dt*Fa(i))/m(i)+v(i);
            an(i+1)=an(i)+wk*dt;
            x(i+1)=x(i)+v(i)*dt*cosd(an(i));
            h(i+1)=h(i)+v(i)*dt*sind(an(i));   
        else % Gravity turn
            Fa(i)=FH15+2*FP238-0.5*1.225*Aef1*((v(i))^2)*exp(-0.00011856*h(i))-(g*m(i)*(R/(R+h(i)))^2-(m(i)*(v(i)*cosd(an(i)))^2)/(R+h(i)))*sind(an(i));
            a(i)=Fa(i)/m(i);
            Fn(i)=-(g*m(i)*(R/(R+h(i)))^2-((m(i)*(v(i)*cosd(an(i)))^2)/(R+h(i))))*cosd(an(i));
            v(i+1)=(dt*Fa(i))/m(i)+v(i);
            an(i+1)=((180/pi)*dt*Fn(i))/(m(i)*v(i))+an(i);
            x(i+1)=x(i)+v(i)*dt*cosd(an(i));
            h(i+1)=h(i)+v(i)*dt*sind(an(i)); 
        end
    end
        
    m(i+1)=m(i+1)-2*mP238;
    
    for i=(k1+1):k2 % Gravity turn with H158
        t(i+1)=dt*i;
        m(i+1)=m(i)-dt*tasaH15;
        Fa(i)=FH15-0.5*1.225*Aef2*((v(i))^2)*exp(-0.00011856*h(i))-(g*m(i)*(R/(R+h(i)))^2-(m(i)*(v(i)*cosd(an(i)))^2)/(R+h(i)))*sind(an(i));
        a(i)=Fa(i)/m(i);
        Fn(i)=-(g*m(i)*(R/(R+h(i)))^2-((m(i)*(v(i)*cosd(an(i)))^2)/(R+h(i))))*cosd(an(i));
        v(i+1)=(dt*Fa(i))/m(i)+v(i);
        an(i+1)=((180/pi)*dt*Fn(i))/(m(i)*v(i))+an(i);
        x(i+1)=x(i)+v(i)*dt*cosd(an(i));
        h(i+1)=h(i)+v(i)*dt*sind(an(i)); 
    end
    an0=an(i+1);
    m(i+1)=m(i+1)-mH15;   
    for i=(k2+1):k3 % Bilineal tangental maneuvre with Aestus
        t(i+1)=dt*i;
        m(i+1)=m(i)-dt*tasaAestus;
        Fa(i)=FAestus-0.5*1.225*Aef3*((v(i))^2)*exp(-0.00011856*h(i))-(g*m(i)*(R/(R+h(i)))^2-(m(i)*(v(i)*cosd(an(i)))^2)/(R+h(i)))*sind(an(i));
        a(i)=Fa(i)/m(i);
        Fn(i)=Fn(i-1);
        v(i+1)=(dt*Fa(i))/m(i)+v(i);
        an(i+1)=atand(tand(an0)*(1-(t(i+1)-t3)/t4));
        x(i+1)=x(i)+v(i)*dt*cosd(an(i));
        h(i+1)=h(i)+v(i)*dt*sind(an(i));
    end
    for i=(k3+1):(k_final-1) % Free drift
        t(i+1)=dt*i;
        m(i+1)=m(i);
        Fa(i)=-0.5*1.225*Aef3*((v(i))^2)*exp(-0.00011856*h(i))-(g*m(i)*(R/(R+h(i)))^2-(m(i)*(v(i)*cosd(an(i)))^2)/(R+h(i)))*sind(an(i));
        a(i)=Fa(i)/m(i);
        Fn(i)=-(g*m(i)*(R/(R+h(i)))^2-((m(i)*(v(i)*cosd(an(i)))^2)/(R+h(i))))*cosd(an(i));
        v(i+1)=(dt*Fa(i))/m(i)+v(i);
        an(i+1)=((180/pi)*dt*Fn(i))/(m(i)*v(i))+an(i);
        x(i+1)=x(i)+v(i)*dt*cosd(an(i));
        h(i+1)=h(i)+v(i)*dt*sind(an(i));
    end

end