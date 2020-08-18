function [F,dist]=travelling_salesman(ind,distancias)
    
    % This function calculates the fitness of each individual of a certain
    % generation. 
    % Inputs:
    % ind: current generation
    % distancias: matrix with the distances between all the points that the
    % salesman has to travel.
    % Outputs:
    % F: fitness
    % dist: correspondant distance of the path of each individual
    
    m=size(ind,1);
    k=size(ind,2);
    dist=zeros(m,1);

    for i=1:m
        for j=1:k-1
            dist(i)=dist(i)+distancias(ind(i,j),ind(i,j+1));
        end
        dist(i)=dist(i)+distancias(ind(i,1),ind(i,k));
    end
    F=1./dist;

end