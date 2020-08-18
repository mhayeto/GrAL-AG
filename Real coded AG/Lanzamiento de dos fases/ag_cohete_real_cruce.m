% DESIGNED GA FOR THE FUEL OPTIMISATION OF A TWO-STAGE LAUNCHER PROBLEM
% USING ONE POINT CROSSOVER

clear all;

% GA parameters
it=1000000; % Max iterations
tiempo=120;  % Min iterations
Pc=0.7; % Crossover rate
Pm=0.02; % Mutation rate
e=1; % Elitism 1: Yes 0: No
m=20; % Size of population
k=2; % Size of individuals

% Problem specifications
Mmin=0;
Mmax=10^6;

MASAS=zeros(m,k,it);
F=zeros(m,it);
P=zeros(m,it);
P2=zeros(m,it);
pos=zeros(m,it);
media=zeros(1,it);

% Initialization of the population
masas=crear_aleatorio_real(Mmin,Mmax,m,k);

% Stopping conditions' parameters.
b=1;
t0=cputime;
t=cputime-t0;
cc=0;
% GA
while b<it && t<tiempo && cc<=2000
    
    % Properties of the generation b
    MASAS(:,:,b)=masas;
    
    % Evaluation of the generation b
    F(:,b)=cohete(MASAS(:,:,b));
    
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
    [P(:,b),P2(:,b),pos(:,b),masas2]=roulette_wheel(MASAS(:,:,b),F(:,b),e);
   
    % Crossover
    [C,cont]=comprobar_cruce(masas2,Pc,e);
    masas3=masas2;
    if cont~=0 || cont~=1
        for j=1:2:cont-1
           ind=C(j);
           ind2=C(j+1);          
           [masas3(ind,:),masas3(ind2,:)]=cruce(masas2(ind,:),masas2(ind2,:));
        end
    end
    
    %Mutation
    masas=random_mutation(masas3,Pm,Mmax,Mmin,e);
        
    b=b+1;
    t=cputime-t0;
        
end