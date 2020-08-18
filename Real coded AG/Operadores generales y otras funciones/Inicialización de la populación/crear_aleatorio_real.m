function y=crear_aleatorio_real(Ymin,Ymax,m,k)

    % This function creates a matrix of m rows and k colums with random 
    % values between Ymin and Ymax

    y=zeros(m,k);

    for j=1:m
        for i=1:k
            y(j,i)=Ymin+(Ymax-Ymin)*rand;
        end
    end 

end