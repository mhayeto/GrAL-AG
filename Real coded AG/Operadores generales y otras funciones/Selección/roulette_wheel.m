function [P,P2,pos,y2]=roulette_wheel(y,F,e)
    % This function inplements the roulette_wheel strategy to choose the
    % individuals who will have the opportunity to be part of the next
    % generation 
    % Inputs:
    % y: population of a certain generation
    % F: matrix with fitness of each individual of y
    % e: 1: elitism 0: no elitism
    % Outputs:
    % P: Probability of each individual of being selected.
    % P2: Sorted P
    % pos: Position of the i element of P2 in P.
    % y2: Chosen individuals.

    m=size(y,1);
    y2=zeros(size(y));
    
    %Probabilities
    P=F./sum(F);
    [P2,pos]=sort(P);
    
    %Design of the roulette
    suma=0;
    R=zeros(1,m);
    for j=1:m
        suma=suma+P2(j);
        R(j)=suma;
    end
    
    % Elitism
    if e==1
        y2(1,:)=y(pos(m),:);
        a=2;
    else
        a=1;
    end
   
    % Roulette wheel algorithm
    for i=a:m
        num=rand;
        for j=1:m
            if num<=R(j)
                ind=pos(j);
                y2(i,:)=y(ind,:);
                break;
            end
        end
    end

end