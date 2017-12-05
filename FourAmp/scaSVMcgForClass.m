function [bestCVaccuarcy,bestc,bestg,sca_option] = scaSVMcgForClass(train_label,train,sca_option)
% ����FarutoUltimate3.1��psoSVMcgForClass�޸�
% psoSVMcgForClass
%
% by faruto
%Email:patrick.lee@foxmail.com QQ:516667408 http://blog.sina.com.cn/faruto
%last modified 2011.06.08
% ��ת����ע����
% faruto and liyang , LIBSVM-farutoUltimateVersion 
% a toolbox with implements for support vector machines based on libsvm, 2011. 
% 
% Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for
% support vector machines, 2001. Software available at
% http://www.csie.ntu.edu.tw/~cjlin/libsvm
%% ������ʼ��
if nargin == 2
    sca_option = struct('maxgen',200,'sizepop',20,'v',5, ...
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

eps = 1e-1;

%% ������ʼ���Ӻ��ٶ�
for i=1:sca_option.sizepop%��ÿ��������˵
    
    % ���������Ⱥ���ٶ�
    pop(i,1) = (sca_option.popcmax-sca_option.popcmin)*rand+sca_option.popcmin;
    pop(i,2) = (sca_option.popgmax-sca_option.popgmin)*rand+sca_option.popgmin;

    % �����ʼ��Ӧ��
    cmd = ['-v ',num2str(sca_option.v),' -c ',num2str( pop(i,1) ),' -g ',num2str( pop(i,2) )];
    fitness(i) = svmtrain(train_label, train, cmd);
    fitness(i) = -fitness(i);
end

% �Ҽ�ֵ�ͼ�ֵ��
[global_fitness bestindex]=min(fitness); % ȫ�ּ�ֵ�����ھֲ���ֵ�е�λ��
local_fitness=fitness;   % ���弫ֵ��ʼ��

global_x=pop(bestindex,:);   % ȫ�ּ�ֵ������
local_x=pop;    % ���弫ֵ�������ʼ��

% ÿһ����Ⱥ��ƽ����Ӧ��
avgfitness_gen = zeros(1,sca_option.maxgen);

%% ����Ѱ��
for i=1:sca_option.maxgen
    
    a = 2;%�����ݼ���0
    r1=a-i*((a)/sca_option.maxgen); % r1 decreases linearly from a to 0
    
    for j=1:sca_option.sizepop
        
        %��Ⱥ����
        % Update r2, r3, and r4 for Eq. (3.3)
        r2=(2*pi)*rand();
        r3=2*rand;
        r4=rand();

        % Eq. (3.3)
        if r4<0.5
            % Eq. (3.1)
            pop(j,:)= pop(j,:)+(r1*sin(r2)*abs(r3*global_x-pop(j,:)));
        else
            % Eq. (3.2)
            pop(j,:)= pop(j,:)+(r1*cos(r2)*abs(r3*global_x-pop(j,:)));
        end
        
        if pop(j,1) > sca_option.popcmax
            pop(j,1) = sca_option.popcmax;
        end
        if pop(j,1) < sca_option.popcmin
            pop(j,1) = sca_option.popcmin;
        end
        if pop(j,2) > sca_option.popgmax
            pop(j,2) = sca_option.popgmax;
        end
        if pop(j,2) < sca_option.popgmin
            pop(j,2) = sca_option.popgmin;
        end
        
%         % ����Ӧ���ӱ���
%         if rand>0.5
%             k=ceil(2*rand);
%             if k == 1
%                 pop(j,k) = (20-1)*rand+1;
%             end
%             if k == 2
%                 pop(j,k) = (sca_option.popgmax-sca_option.popgmin)*rand + sca_option.popgmin;
%             end
%         end
        
        %��Ӧ��ֵ
        cmd = ['-v ',num2str(sca_option.v),' -c ',num2str( pop(j,1) ),' -g ',num2str( pop(j,2) )];
        fitness(j) = svmtrain(train_label, train, cmd);
        fitness(j) = -fitness(j);
        
%         cmd_temp = ['-c ',num2str( pop(j,1) ),' -g ',num2str( pop(j,2) )];
%         model = svmtrain(train_label, train, cmd_temp);
        
        if fitness(j) >= -65
            continue;
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
    avgfitness_gen(i) = sum(fitness)/sca_option.sizepop;
end

%% �������
figure;
hold on;
plot(-fit_gen,'r*-');
plot(-avgfitness_gen,'o-');
legend('�����Ӧ��','ƽ����Ӧ��',3);
xlabel('��������','FontSize',12);
ylabel('��Ӧ��','FontSize',12);
grid on;

bestc = global_x(1);
bestg = global_x(2);
bestCVaccuarcy = -fit_gen(sca_option.maxgen);

line1 = '��Ӧ������Accuracy[PSOmethod]';
line2 = ['(��ֹ����=', ...
    num2str(sca_option.maxgen),',��Ⱥ����pop=', ...
    num2str(sca_option.sizepop),')'];
% line3 = ['Best c=',num2str(bestc),' g=',num2str(bestg), ...
%     ' CVAccuracy=',num2str(bestCVaccuarcy),'%'];
% title({line1;line2;line3},'FontSize',12);
title({line1;line2},'FontSize',12);


