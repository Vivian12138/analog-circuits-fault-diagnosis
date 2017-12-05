c1=1.5;
c2=1.7;
maxgen=200;
sizepop=20;
k=0.6;
wV=1;
wP=1;
v=3;
popcmax=100;
popcmin=0.1;
popgmax=1000;
popgmin=0.01;

Vcmax = pso_option.k*pso_option.popcmax;%�����ٶ�
Vcmin = -Vcmax ;
Vgmax = pso_option.k*pso_option.popgmax;
Vgmin = -Vgmax ;

eps = 1e-1;

%% ������ʼ���Ӻ��ٶ�
for i=1:pso_option.sizepop
    
    % ���������Ⱥ���ٶ�
    pop(i,1) = (pso_option.popcmax-pso_option.popcmin)*rand+pso_option.popcmin;%rand  0-1��̬�ֲ�
    pop(i,2) = (pso_option.popgmax-pso_option.popgmin)*rand+pso_option.popgmin;
    V(i,1)=Vcmax*rands(1,1);
    V(i,2)=Vgmax*rands(1,1);
    
    % �����ʼ��Ӧ��
    cmd = ['-v ',num2str(pso_option.v),' -c ',num2str( pop(i,1) ),' -g ',num2str( pop(i,2) )];
    fitness(i) = svmtrain(train_label, train, cmd);
    fitness(i) = -fitness(i);%����Сֵ
end

% �Ҽ�ֵ�ͼ�ֵ��
[global_fitness bestindex]=min(fitness); % ȫ�ּ�ֵ�����
local_fitness=fitness;   % ���弫ֵ��ʼ��

global_x=pop(bestindex,:);   % ȫ�ּ�ֵ��pop(c,g)
local_x=pop;    % ���弫ֵ���ʼ��

% ÿһ����Ⱥ��ƽ����Ӧ��
avgfitness_gen = zeros(1,pso_option.maxgen);