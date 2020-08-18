function [hijo1,hijo2]=cruce(padre1,padre2)
    
    % This function carries out the one-point crossover.
    % Inputs:
    % padre1, padre2: the individuals to crossover (parents)
    % Outputs:
    % hijo1, hijo2: the new individuals created from parents.
    
    t1=size(padre1,2);
    mitad=ceil(t1/2);
    hijo1=[padre1(1:mitad), padre2(mitad+1:end)];
    hijo2=[padre2(1:mitad), padre1(mitad+1:end)];
    
end





