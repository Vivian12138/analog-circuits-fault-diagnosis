%% �Ӻ��� gsaSVMcgForClass.m
function [bestCVaccuarcy,bestc,bestg,hisAcc] = gsaSVMcgForClass(train_label,train)
% gsaSVMcgForClass
% ������ʼ��
% if nargin == 2
%     gsa_option = struct('max_it',100,'N',20, ...
%          'popcmax',10^2,'popcmin',10^(-1),'popgmax',10^3,'popgmin',10^(-2));
% end
% c1:��ʼΪ1.5,pso�����ֲ���������     ���ٶ�����
% c2:��ʼΪ1.7,pso����ȫ����������     ���ٶ�����
% maxgen:��ʼΪ200,����������
% sizepop:��ʼΪ20,��Ⱥ�������
% k:��ʼΪ0.6(k belongs to [0.1,1.0]),���ʺ�x�Ĺ�ϵ(V = kX)
% wV:��ʼΪ1(wV best belongs to [0.8,1.2]),���ʸ��¹�ʽ���ٶ�ǰ��ĵ���ϵ��
% wP:��ʼΪ1,��Ⱥ���¹�ʽ���ٶ�ǰ��ĵ���ϵ��
% v:��ʼΪ3,SVM Cross Validation����
% popcmax:��ʼΪ100,SVM ����c�ı仯�����ֵ.
% popcmin:��ʼΪ0.1,SVM ����c�ı仯����Сֵ.
% popgmax:��ʼΪ1000,SVM ����g�ı仯�����ֵ.
% popgmin:��ʼΪ0.01,SVM ����c�ı仯����Сֵ.
% 

%  inputs:
% N:  Number of agents.
% max_it: Maximum number of iterations (T).
% ElitistCheck: If ElitistCheck=1, algorithm runs with eq.21 and if =0, runs with eq.9.
% Rpower: power of 'R' in eq.7.
% F_index: The index of the test function. See tables 1,2,3 of the mentioned article.
%          Insert your own objective function with a new F_index in 'test_functions.m'
%          and 'test_functions_range.m'.
%  outputs:
% Fbest: Best result. 
% Lbest: Best solution. The location of Fbest in search space.
% BestChart: The best so far Chart over iterations. 
% MeanChart: The average fitnesses Chart over iterations.

max_it=100;
N=20;
Xcmax=10^3;
Xcmin=10^(-1);
Xgmax=10^3;
Xgmin=10^(-2);
ElitistCheck=1; 
Rpower=1;
min_flag=0; % 1: minimization, 0: maximization
gsa_v=5; % gsa_v:��ʼΪ3,SVM Cross Validation����

%V:   Velocity.
%a:   Acceleration.
%M:   Mass.  Ma=Mp=Mi=M;
%dim: Dimension of the test function.
%N:   Number of agents.
%X:   Position of agents. dim-by-N matrix.
%R:   Distance between agents in search space.
%[low-up]: Allowable range for search space.
%Rnorm:  Norm in eq.8.
%Rpower: Power of R in eq.7.

Rnorm=2;
dim=2;
up=[10^3 10^3];
low=[10^(-1) 10^(-2)];
% ������ʼ���Ӻ��ٶ�
for i=1:N
    % ���������Ⱥ���ٶ�
    X(i,1) = (Xcmax-Xcmin)*rand+Xcmin;
    X(i,2) = (Xgmax-Xgmin)*rand+Xgmin;
end

%create the best so far chart and average fitnesses chart.
BestChart=[];MeanChart=[];

V=zeros(N,dim);

for iteration=1:max_it
    %     iteration
    
    %Checking allowable range.
    [N,dim]=size(X);
    for i=1:N
        %     %%Agents that go out of the search space, are reinitialized randomly .
        Tp=X(i,:)>up;
        Tm=X(i,:)<low;
        X(i,:)=(X(i,:).*(~(Tp+Tm)))+((rand(1,dim).*(up-low)+low).*(Tp+Tm));
    end
    
    %Evaluation of agents.
    % % % % % % % % % % % % % % % % % % % % % % % % % % % %     rr
    for i=1:N
        %L is the location of agent number 'i'
        L=X(i,:);
        %calculation of objective function for agent number 'i'
       
        
        % �����ʼ��Ӧ��
        cmd = ['-v ',num2str(gsa_v),' -c ',num2str( X(i,1) ),' -g ',num2str( X(i,2) )];
        fitness(i) = svmtrain(train_label, train, cmd);  %�����ֵ
     
    end
    
    % % % % % % % % % % % % % % % % % % % % %
    
    if min_flag==1
        [best best_X]=min(fitness); %minimization.
    else
        [best best_X]=max(fitness); %maximization.
    end
    
    if iteration==1
        Fbest=best;
        Lbest=X(best_X,:);
    end
    if min_flag==1
        if best<Fbest  %minimization.
            Fbest=best;
            Lbest=X(best_X,:);
        end
    else
        if best>Fbest  %maximization
            Fbest=best;
            Lbest=X(best_X,:);
        end
    end
    
    BestChart=[BestChart Fbest];
    MeanChart=[MeanChart mean(fitness)];
    
    %Calculation of M. eq.14-20
    % [M]=massCalculation(fitness,min_flag);
    
    Fmax=max(fitness); Fmin=min(fitness); Fmean=mean(fitness);
    
    if Fmax==Fmin
        M=ones(N,1);
    else
        
        if min_flag==1 %for minimization
            best=Fmin;worst=Fmax; %eq.17-18.
        else %for maximization
            best=Fmax;worst=Fmin; %eq.19-20.
        end
        
        M=(fitness-worst)./(best-worst); %eq.15,
        
    end
    
    M=M./sum(M); %eq. 16.
    %Calculation of Gravitational constant. eq.13.
    % G=Gconstant(iteration,max_it);
    
    alfa=20;G0=100;
    G=G0*exp(-alfa*iteration/max_it); %eq. 28.
    
    %Calculation of accelaration in gravitational field. eq.7-10,21.
    final_per=2; %In the last iteration, only 2 percent of agents apply force to the others.
    
    %%%%total force calculation
    if ElitistCheck==1
        kbest=final_per+(1-iteration/max_it)*(100-final_per); %kbest in eq. 21.
        kbest=round(N*kbest/100);
    else
        kbest=N; %eq.9.
    end
    [Ms ds]=sort(M,'descend');
    
    for i=1:N
        E(i,:)=zeros(1,dim);
        for ii=1:kbest
            j=ds(ii);
            if j~=i
                R=norm(X(i,:)-X(j,:),Rnorm); %Euclidian distanse.
                for k=1:dim
                    E(i,k)=E(i,k)+rand*(M(j))*((X(j,k)-X(i,k))/(R^Rpower+eps));
                    %note that Mp(i)/Mi(i)=1
                end
            end
        end
    end
    
    %%acceleration
    a=E.*G; %note that Mp(i)/Mi(i)=1
    %Agent movement. eq.11-12
    V=rand(N,dim).*V+a; %eq. 11.
    X=X+V; %eq. 12.
end %iteration

bestCVaccuarcy=best;
bestc=Lbest(1);
bestg=Lbest(2);

% semilogy(BestChart,'--k');
%  title(['\fontsize{12}\bf F',num2str(F_index)]);
%  xlabel('\fontsize{12}\bf Iteration');ylabel('\fontsize{12}\bf Best-so-far');
%  legend('\fontsize{10}\bf GSA',1);



 
