function [hijo1,hijo2]=ts_crossover(padre1,padre2)
    
    % This function carries out the crossover for the TSP problem.
    % Inputs:
    % padre1, padre2: the individuals to crossover (parents)
    % Outputs:
    % hijo1, hijo2: the new individuals created from parents.

    k=length(padre1);
    
    [hijo1,hijo2,a]=n_point_crossover_bit(3,0,padre1,padre2);

    [val_uniq1,ind_uniq1]=unique(hijo1);
    [val_uniq2,ind_uniq2]=unique(hijo2);

    ind_rep1=setdiff(1:k,ind_uniq1);
    ind_rep2=setdiff(1:k,ind_uniq2);

    m=length(ind_rep1);
    if m==0
        return;
    end

    ind1=zeros(m,1);
    ind2=zeros(m,1);

    for i=1:m
        c1=find(hijo1==hijo1(ind_rep1(i)));
        if c1(1)<=a(1) || c1(1)>a(2)
            ind1(i)=c1(1);
        else
            ind1(i)=c1(2);
        end
        c2=find(hijo2==hijo2(ind_rep2(i)));
        if c2(1)<=a(1) || c2(1)>a(2)
            ind2(i)=c2(1);
        else
            ind2(i)=c2(2);
        end
    end

    ind1=unique(ind1);
    ind2=unique(ind2);
    n=length(ind1);

    for i=1:n-1
        w=hijo1(ind1(i));
        hijo1(ind1(i))=hijo2(ind2(i+1));
        hijo2(ind2(i+1))=w;
    end
    w=hijo1(ind1(n));
    hijo1(ind1(n))=hijo2(ind2(1));
    hijo2(ind2(1))=w;

end