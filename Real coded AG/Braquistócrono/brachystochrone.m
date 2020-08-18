function [T,F]=brachystochrone(dx,dy,y,Y0)
    % This function calculates the fitness of each individual of a certain
    % generation. 
    % Inputs:
    % dx: distance between points in X axis (constant in this case).
    % dy: matrix withdistance between adjacent points of all individuals,
    % in Y axis.
    % y: current generation
    % Y0: First point's Y value.
    % Outputs:
    % F: fitness
    % T: time

    g=9.8;

    m=size(y,1);
    k=size(y,2);
    dt=zeros(m,k-1);
    T=zeros(1,m);

    for j=1:m
        for i=1:k-1
            if dy(j,i)==0
                dt(j,i)=dx/sqrt(2*g*(Y0-y(j,i+1)));
            else
                dt(j,i)=(sqrt(dx^2+(dy(j,i))^2))/(g*dy(j,i))*(sqrt(2*g*(Y0-y(j,i+1))+2*g*dy(j,i))-sqrt(2*g*(Y0-y(j,i+1))));
            end
        end
    end

    for j=1:m
        T(j)=0;
            for i=1:k-1
                T(j)=T(j)+dt(j,i);
            end
    end

    F=1./T;

end

