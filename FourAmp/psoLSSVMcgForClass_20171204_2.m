function [bestCVaccuarcy,bestgam,bestsig2,pso_option] = psoLSSVMcgForClass(trainset,trainset_label,pso_option)
% psoLSSVMcgForClass 
%by Tangxiaobiao  QQ 444646122 blog.sina.com.cn/lssvm
% 2010.05.31
% ���Ĳ��������ʾby KingsleyChu
% 2017.12.04
%% ������ʼ��
if nargin == 2
    pso_option = struct('c1',1.5,'c2',1.7,'maxgen',20,'sizepop',20, ...
        'k',0.6,'wV',1,'wP',1,'v',5, ...
        'popcmax',10^2,'popcmin',10^(-1),'popgmax',10^3,'popgmin',10^(-2));
end
% c1:��ʼΪ1.5,pso�����ֲ���������
% c2:��ʼΪ1.7,pso����ȫ����������
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
% Yc=Yc;
Vcmax = pso_option.k*pso_option.popcmax;
Vcmin = -Vcmax ;
Vgmax = pso_option.k*pso_option.popgmax;
Vgmin = -Vgmax ;

eps = 10^(-3);
[Yc,codebook,old_codebook] = code(trainset_label,'code_MOC');
%% ������ʼ���Ӻ��ٶ�
for i=1:pso_option.sizepop
    
    % ���������Ⱥ���ٶ�
    pop(i,1) = (pso_option.popcmax-pso_option.popcmin)*rand+pso_option.popcmin;
    pop(i,2) = (pso_option.popgmax-pso_option.popgmin)*rand+pso_option.popgmin;
    V(i,1)=Vcmax*rands(1);
    V(i,2)=Vgmax*rands(1);
    
    % �����ʼ��Ӧ��
    gam=pop(i,1);sig2=pop(i,2);
    model=initlssvm(trainset,Yc,'c',gam,sig2,'RBF_kernel');
    model.kernel_pars=sig2;
    model=trainlssvm(model);
    Yd0=simlssvm(model,trainset);
    predict_label = code(Yd0,old_codebook,[],codebook);%���������
    testnum=size(trainset_label,1);
    right=sum(trainset_label==predict_label);
%     n = sum(trainset_label~=predict_label);
%     fitness(i) = (1-n/prod(size(trainset_label)))*100;%prod��������Ԫ�ص����˻�,��labelֻ��1�У���ΪԪ�ظ���
    fitness(i) = (right/testnum)*100;
	fitness(i) = -fitness(i);
end

% �Ҽ�ֵ�ͼ�ֵ��
[global_fitness bestindex]=min(fitness); % ȫ�ּ�ֵ
local_fitness=fitness;   % ���弫ֵ��ʼ��

global_x=pop(bestindex,:);   % ȫ�ּ�ֵ��
local_x=pop;    % ���弫ֵ���ʼ��

% ÿһ����Ⱥ��ƽ����Ӧ��
avgfitness_gen = zeros(1,pso_option.maxgen);

%% ����Ѱ��
for i=1:pso_option.maxgen
    
    for j=1:pso_option.sizepop
        
        %�ٶȸ���
        V(j,:) = pso_option.wV*V(j,:) + pso_option.c1*rand*(local_x(j,:) - pop(j,:)) + pso_option.c2*rand*(global_x - pop(j,:));
        if V(j,1) > Vcmax
            V(j,1) = Vcmax;
        end
        if V(j,1) < Vcmin
            V(j,1) = Vcmin;
        end
        if V(j,2) > Vgmax
            V(j,2) = Vgmax;
        end
        if V(j,2) < Vgmin
            V(j,2) = Vgmin;
        end
        
        %��Ⱥ����
        pop(j,:)=pop(j,:) + pso_option.wP*V(j,:);
        if pop(j,1) > pso_option.popcmax
            pop(j,1) = pso_option.popcmax;
        end
        if pop(j,1) < pso_option.popcmin
            pop(j,1) = pso_option.popcmin;
        end
        if pop(j,2) > pso_option.popgmax
            pop(j,2) = pso_option.popgmax;
        end
        if pop(j,2) < pso_option.popgmin
            pop(j,2) = pso_option.popgmin;
        end
        
        % ����Ӧ���ӱ���
        if rand>0.5
            k=ceil(2*rand);
            if k == 1
                pop(j,k) = (20-1)*rand+1;
            end
            if k == 2
                pop(j,k) = (pso_option.popgmax-pso_option.popgmin)*rand + pso_option.popgmin;
            end
        end
        
        %��Ӧ��ֵ
     gam=pop(j,1);sig2=pop(j,2);
     model=initlssvm(trainset,Yc,'c',gam,sig2,'RBF_kernel');
     model=trainlssvm(model);
     Yd0=simlssvm(model,trainset);
     predict_label = code(Yd0,old_codebook,[],codebook);%���������
     testnum=size(trainset_label,1);
     right=sum(trainset_label==predict_label);
     n = sum(sum(trainset_label~=predict_label));
     fitness(j) = (1-n/prod(size(trainset_label)))*100;
     fitness(j) = -fitness(j);

     gam=pop(j,1);sig2=pop(j,2);
     model=initlssvm(trainset,Yc,'c',gam,sig2,'RBF_kernel');
     model=trainlssvm(model); 
     
        if fitness(j) >= -65
            continue;
        end
        
        %�������Ÿ���
        if fitness(j) < local_fitness(j)
            local_x(j,:) = pop(j,:);
            local_fitness(j) = fitness(j);
        end
        
        if abs( fitness(j)-local_fitness(j) )<=eps && pop(j,1) < local_x(j,1)
            local_x(j,:) = pop(j,:);
            local_fitness(j) = fitness(j);
        end
        
        %Ⱥ�����Ÿ���
        if fitness(j) < global_fitness
            global_x = pop(j,:);
            global_fitness = fitness(j);
        end
        
        if abs( fitness(j)-global_fitness )<=eps && pop(j,1) < global_x(1)
            global_x = pop(j,:);
            global_fitness = fitness(j);
        end
        
    end
    
    fit_gen(i) = global_fitness;
    avgfitness_gen(i) = sum(fitness)/pso_option.sizepop;
end

%% �������
figure;
hold on;
plot(-fit_gen,'r*-','LineWidth',1.5);
plot(-avgfitness_gen,'o-','LineWidth',1.5);
legend('�����Ӧ��','ƽ����Ӧ��',3);
xlabel('��������','FontSize',10);
ylabel('��Ӧ��','FontSize',10);
grid on;

% print -dtiff -r600 pso

bestgam = global_x(1);
bestsig2 = global_x(2);
bestCVaccuarcy = -fit_gen(pso_option.maxgen);

line1 = 'PSO optimize LSSVM-Classification model';
line2 = ['(����c1=',num2str(pso_option.c1), ...
    ',c2=',num2str(pso_option.c2),',��ֹ����=', ...
    num2str(pso_option.maxgen),',��Ⱥ����pop=', ...
    num2str(pso_option.sizepop),')'];
line3 = ['Best gam=',num2str(bestgam),' sig2=',num2str(bestsig2), ...
    ' PSO-cvaccuracy=',num2str(bestCVaccuarcy),'%'];
title({line1;line2;line3},'FontSize',10);


