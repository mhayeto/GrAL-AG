% Calculates the shortest path to travel along the (Xi,Yi) points comparing
% all the possible combinations.

X=[2 4 4 10 8 1 10 7];
Y=[5 2 10 9 10 1 9 10];
a=[1 2 3 4 5 6 7 8];
datos=[X;Y];
C=perms(a);
m=size(C,1);
k=size(C,2);
distancias=calcular_distancias(datos);
ona=0;
d=0;
dist=0;
for j=1:k-1
    d=d+distancias(C(1,j),C(1,j+1));
end
d=d+distancias(C(i,1),C(i,k));

for i=2:m
    dist=0;
    for j=1:k-1
        dist=dist+distancias(C(i,j),C(i,j+1));
    end
    dist=dist+distancias(C(i,1),C(i,k));
    if dist<d
        ona=i;
        d=dist;
    end
end
