function [hijo1,hijo2,a]=n_point_crossover_bit(n,unif,padre1,padre2)
    
    % This function carries out the n-point crossover.
    % Inputs:
    % n: Amount of points by which the parents will be cut.
    % unif: 1: parts to crossover of the same length 0: parts to crossover
    % of random lenght.
    % padre1, padre2: the individuals to crossover (parents)
    % Outputs:
    % hijo1, hijo2: the new individuals created from parents.
    % a: 1 if unif: 1, vector with the n points by which the parents have
    % been cut.
    
    k=size(padre1,2);
    hijo1=padre1;
    hijo2=padre2;
    a=unif;
    if unif==1
        punto=round(k/n);
        if mod(n,2)==0
            for i=1:2*punto:k-1
                hijo1(i:i+punto-1)=padre2(i:i+punto-1);
                hijo2(i:i+punto-1)=padre1(i:i+punto-1);
            end
        else
            for i=1+punto:2*punto:k-1
                hijo1(i:i+punto-1)=padre2(i:i+punto-1);
                hijo2(i:i+punto-1)=padre1(i:i+punto-1);
            end
        end
    else
        if unif==0
            a=unique(randi(k-1,1,n-1));
            while size(a)~=n-1
                a=unique(randi(k-1,1,n-1));
            end
        end
        hijo1(1:a(1))=padre2(1:a(1));
        hijo2(1:a(1))=padre1(1:a(1));
        for i=2:2:n-2
            hijo1(a(i)+1:a(i+1))=padre2(a(i)+1:a(i+1));
            hijo2(a(i)+1:a(i+1))=padre1(a(i)+1:a(i+1));
        end
        if mod(n-1,2)==0
            hijo1(a(n-1)+1:end)=padre2(a(n-1)+1:end);
            hijo2(a(n-1)+1:end)=padre1(a(n-1)+1:end);
        end
    end    

end

  

