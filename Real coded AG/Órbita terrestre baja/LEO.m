function F=LEO(y)
    % This function calculates the fitness of each individual of a certain
    % generation. 
    % Inputs:
    % y: current generation
    % Outputs:
    % F: fitness

    m=size(y,1);
    F=zeros(m,1);

    for i=1:m
        ta=y(i,1);
        tp=y(i,2);
        app=y(i,3);
        F(i)=fitness_LEO(ta,tp,app);
    end
    
end