function distancias=calcular_distancias(datos)
    % This function calculates all the distances of the points that the
    % salesman has to travel.
    % Inputs:
    % datos: the points
    % Outputs:
    % distancias: distances
    
    dim=size(datos,1);
    k=size(datos,2);
    distancias=zeros(k,k);

    for i=1:k
        for j=i+1:k
            d=0;
            for t=1:dim
                d=d+(datos(t,i)-datos(t,j))^2;
            end
            distancias(i,j)=sqrt(d);
            distancias(j,i)=sqrt(d);
        end
    end
    
end