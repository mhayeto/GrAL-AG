function [C,cont]=comprobar_cruce(y,Pc,e)
    % This function decides which individuals will perform crossover.
    % Inputs:
    % y: generation
    % Pc: crossover rate
    % e: 1: elitism 0: no elitism
    % Outputs:
    % C: vector with the indices of the individuals in y which will perform
    % crossover.
    % cont: Amount of individuals which will perform crossover.

    m=size(y,1);
    C=[];
    cont=0;
    if e==1
        a=2;
    else
        a=1;
    end
    
    for j=a:m
        num3=rand;
        if num3<=Pc
            cont=cont+1;
            C=[C;j];
        end
    end
    
end