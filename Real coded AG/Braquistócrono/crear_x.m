function x=crear_x(Xmin,Xmax,k)
    % This function discretizes the range between Xmin and Xmax in k parts
    
    x=zeros(1,k+1);
    x(1)=Xmin;
    for i=2:k
        x(i)=Xmin+(Xmax-Xmin)*(i-1)/k;
    end
    x(k+1)=Xmax;
    
end
