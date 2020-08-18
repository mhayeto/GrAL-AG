% DESIGNED GA FOR THE BRACHYSTOCHRONE'S PROBLEM

clear all;

% GA parameters
it=1000000; % Max iterations
tiempo=30;  % Min iterations
Pc=0.7; % Crossover rate
Pm=0.02; % Mutation rate
e=1; % Elitism 1: Yes 0: No
m=20; % Size of population

% Brachystochrone's problem specifications
Xmin=0; % Fixed first x value
Xmax=1; % Fixed last x value
Yk=0; % Fixed first y value
Y0=1; % Fixed last y value
Ymin=-1; % Min possible value for y
Ymax=1; % Max possible value for y
k=6; % Number of discretization points (except bounds) = Size of individuals
X=crear_x(Xmin,Xmax,k+1);
dx=(Xmax-Xmin)/k;

y_crom=zeros(m,k,it);
dy=zeros(m,k+1,it);
T=zeros(m,it);
F=zeros(m,it);
P=zeros(m,it);
P2=zeros(m,it);
pos=zeros(m,it);
Tmejor=zeros(1,it);
media=zeros(1,it);
Y=zeros(m,k+2,it);



% Initialization of the population
Y_crom=crear_aleatorio_real(Ymin,Ymax,m,k);
Y(:,1,:)=Y0;
Y(:,k+2,:)=Yk;

% Stopping conditions' parameters.
b=1;
t0=cputime;
t=cputime-t0;
cc=0;

% GA
while b<it && t<tiempo && cc<=2000
    
    % Properties of the generation b
    y_crom(:,:,b)=Y_crom;
    Y(:,2:k+1,b)=y_crom(:,:,b);
    dy(:,:,b)=dscr(Y(:,:,b));
    
    % Evaluation of the generation b
    [T(:,b),F(:,b)]=brachystochrone(dx,dy(:,:,b),Y(:,:,b),Y0);
    
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
    [P(:,b),P2(:,b),pos(:,b),y2]=roulette_wheel(y_crom(:,:,b),F(:,b),e); 
    Tmejor(b)=T(pos(m,b),b);
    
    % Crossover
    [C,cont]=comprobar_cruce(y2,Pc,e);
    y3=y2;
    if cont~=0 || cont~=1
        for j=1:2:cont-1
           ind=C(j);
           ind2=C(j+1);          
           [y3(ind,:),y3(ind2,:)]=cruce(y2(ind,:),y2(ind2,:)); % Crossover
        end
    end
    
    %Mutation
    Y_crom=random_mutation(y3,Pm,Ymax,Ymin,e);
    
    b=b+1;
    t=cputime-t0;
        
end

 