function [hijo1,hijo2]=flat_crossover(padre1,padre2)
    % This function carries out the flat crossover.
    % Inputs:
    % padre1, padre2: the individuals to crossover (parents)
    % Outputs:
    % hijo1, hijo2: the new individuals created from parents.
    m=size(padre1,2);
    hijo1=zeros(1,m);
    hijo2=zeros(1,m);
    
    for i=1:m
        a=rand;
        hijo1(i)=a*padre1(i)+(1-a)*padre2(i);
        hijo2(i)=a*padre2(i)+(1-a)*padre1(i);
    end

end