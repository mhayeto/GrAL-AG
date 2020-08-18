function F=cohete(y)
    % This function calculates the fitness of each individual of a certain
    % generation. 
    % Inputs:
    % y: current generation
    % Outputs:
    % F: fitness
    
    m=size(y,1);
    F=zeros(m,1);

    for i=1:m
        mc1=y(i,1);
        mc2=y(i,2);
        F(i)=p_final(mc1,mc2);
    end
    
end