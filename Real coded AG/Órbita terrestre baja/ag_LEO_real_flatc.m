% DESIGNED GA FOR LEO ORBIT PROBLEM

clear all;

% GA parameters
it=1000000; % Max iterations
tiempo=1800;  % Min iterations
Pc=0.7; % Crossover rate
Pm=0.02; % Mutation rate
e=1; % Elitism 1: Yes 0: No
m=20; % Size of population
k=3; % Size of individuals

% Problem specifications
ta_min=1;
ta_max=40;
tp_min=1;
tp_max=40;
app_min=89.9;
app_max=75;
kk=1;


PARAMETROS=zeros(m,k,it);
F=zeros(m,it);
P=zeros(m,it);
P2=zeros(m,it);
pos=zeros(m,it);
media=zeros(1,it);

% Initialization of the population
ta=crear_aleatorio_real(ta_min,ta_max,m,kk);
tp=crear_aleatorio_real(tp_min,tp_max,m,kk);
app=crear_aleatorio_real(app_min,app_max,m,kk);

% Stopping conditions' parameters
b=1;
t0=cputime;
t=cputime-t0;
cc=0;

% GA
while b<it && t<tiempo && cc<=2000
    
    parametros=[ta tp app];
    
    % Properties of the generation b
    PARAMETROS(:,:,b)=parametros;
    
    % Evaluation of the generation b
    F(:,b)=LEO(PARAMETROS(:,:,b));
    
    % Convergence of the solutions
    media(b)=mean(F(:,b));
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
    [P(:,b),P2(:,b),pos(:,b),parametros2]=roulette_wheel(PARAMETROS(:,:,b),F(:,b),e);
   
    % Crossover   
    [C,cont]=comprobar_cruce(parametros2,Pc,e);
    parametros3=parametros2;  
    if cont~=0 || cont~=1
        for j=1:2:cont-1
           ind=C(j);
           ind2=C(j+1);          
           [parametros3(ind,:),parametros3(ind2,:)]=flat_crossover(parametros2(ind,:),parametros2(ind2,:));
        end
    end
    
    %Mutation
    ta=random_mutation(parametros3(:,1),Pm,ta_max,ta_min,e);
    tp=random_mutation(parametros3(:,2),Pm,tp_max,tp_min,e);
    app=random_mutation(parametros3(:,3),Pm,app_max,app_min,e);
        
    b=b+1;
    t=cputime-t0;
        
end