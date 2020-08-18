function dy=dscr(y)
    % This function calculates the distance betweent the adjacent points of
    % the individuals in the y axis.
    % Inputs:
    % y: matrix with the y values of the points of all the individuals.
    % Outputs:
    % dy: matrix with all the distances between adjacent points.

    m=size(y,1);
    k=size(y,2);
    dy=zeros(m,k-1);
    
    for j=1:m
        for i=1:k-1
            dy(j,i)=y(j,i+1)-y(j,i);
        end
    end
    
end