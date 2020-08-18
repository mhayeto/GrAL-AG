% DESIGNED GA FOR THE TRAVELLING SALESMAN PROBLEM

clear all;

% GA parameters
it=1000000; % Max iterations
tiempo=300; % Min iterations
Pc=0.7; % Ccrossover rate
Pm=0.02; % Mutation rate
e=1; % Elitism 1: Yes 0: No
m=20; % Size of population

% TSP specifications
puntos=20; % Number of points for the salesman
X=randi(10,1,puntos);
Y=randi(10,1,puntos);
Z=[];
datos=[X;Y;Z]; % Randomly created points
distancias=calcular_distancias(datos);

ORDEN=zeros(m,size(datos,2),it);
k=length(X);
F=zeros(m,it);
P=zeros(m,it);
P2=zeros(m,it);
pos=zeros(m,it);
media=zeros(1,it);

% Initialization of the population
r=rand(m,k);
[r2,orden]=sort(r,2);

% Stopping conditions' parameters.
b=1;
t0=cputime;
t=cputime-t0;
cc=0;



% GA
while b<it && t<tiempo && cc<=2000
    
    % Properties of the generation b
    ORDEN(:,:,b)=orden;

    
    % Evaluation of the generation b
    [F(:,b),dist(:,b)]=travelling_salesman(ORDEN(:,:,b),distancias);
    media(b)=mean(F(:,b));
    
    % Convergence of the solutions
    if b==1
        media1=media(1);
    end
    if b>1
        dif=abs((media(b)-media1))/media1;
        if dif<=0.05
            cc=cc+1;
        else
            cc=0;
            media1=media(b);
        end
    end

        
    % Selection
    [P(:,b),P2(:,b),pos(:,b),orden2]=roulette_wheel(ORDEN(:,:,b),F(:,b),e);
    
    % Crossover
    
    [C,cont]=comprobar_cruce(orden2,Pc,e);
    orden3=orden2;
    if cont~=0 || cont~=1
        for j=1:2:cont-1
           ind=C(j);
           ind2=C(j+1);          
           [orden3(ind,:),orden3(ind2,:)]=ts_crossover(orden2(ind,:),orden2(ind2,:));
        end
    end
    
    % Mutation
    orden=ts_mutation(orden3,Pm,e);
    
    b=b+1;
    t=cputime-t0;
        
end
