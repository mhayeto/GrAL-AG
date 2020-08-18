function y3=random_mutation(y,Pm,Ymax,Ymin,e)
   
    % This function carries out the uniform or random mutation.
    % Inputs:
    % y: the generation susceptible to be mutated
    % Pm: mutation rate
    % Ymax: Max possible Y value to mutate to
    % Ymin: Min possible Y value to mutate to
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
        for i=1:k
            num2=rand;
            if num2<Pm
               y3(j,i)=Ymin+(Ymax-Ymin)*rand;
            end
        end
    end

end