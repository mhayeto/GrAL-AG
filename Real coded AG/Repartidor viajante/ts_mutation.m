function y3=ts_mutation(y,Pm,e)
    % This function carries out the mutation for TSP.
    % Inputs:
    % y: the generation susceptible to be mutated
    % Pm: mutation rate
    % e: 1: elitism 0: no elitism
    % Outputs:
    % y3: next generation    

    m=size(y,1);
    k=size(y,2);
    y3=y;

    if e==1
        a=2;
    else
        a=1;
    end 

    for j=a:m
        num2=rand;
        if num2<Pm
            rr=rand(1,k);
            [rr2,y3(j,:)]=sort(rr);
        end
    end

end