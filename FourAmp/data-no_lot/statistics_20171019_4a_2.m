%statistics_20171019.m
%ͳ����������ȡrange,mean,std,Skewness,Kurtosis,Entropy
%���ѡȡ����,50%
%PCA����ȡ��2�������������64������ȥ����ȥ��
%%
clc;
clear;
disp('---start~');
%%
num_fault=13;%0-12
num_column=200;%����������
num_all=num_fault*num_column;%������������
num_row=1000;%����������ά��
num_train=num_all/2;
num_test=num_all-num_train;
%%
%���ݵ��벢��ӷ����ǩ
fault0 = pspice2data('D:\matlab\FourAmp\data-no_lot\f0.txt',num_row,num_column,0);
fault1 = pspice2data('D:\matlab\FourAmp\data-no_lot\f1.txt',num_row,num_column,1);
fault2 = pspice2data('D:\matlab\FourAmp\data-no_lot\f2.txt',num_row,num_column,2);
fault3 = pspice2data('D:\matlab\FourAmp\data-no_lot\f3.txt',num_row,num_column,3);
fault4 = pspice2data('D:\matlab\FourAmp\data-no_lot\f4.txt',num_row,num_column,4);
fault5 = pspice2data('D:\matlab\FourAmp\data-no_lot\f5.txt',num_row,num_column,5);
fault6 = pspice2data('D:\matlab\FourAmp\data-no_lot\f6.txt',num_row,num_column,6);
fault7 = pspice2data('D:\matlab\FourAmp\data-no_lot\f7.txt',num_row,num_column,7);
fault8 = pspice2data('D:\matlab\FourAmp\data-no_lot\f8.txt',num_row,num_column,8);
fault9 = pspice2data('D:\matlab\FourAmp\data-no_lot\f9.txt',num_row,num_column,9);
fault10 = pspice2data('D:\matlab\FourAmp\data-no_lot\f10.txt',num_row,num_column,10);
fault11 = pspice2data('D:\matlab\FourAmp\data-no_lot\f11.txt',num_row,num_column,11);
fault12 = pspice2data('D:\matlab\FourAmp\data-no_lot\f12.txt',num_row,num_column,12);
disp('---data import complete!');
%%
%���ݺϲ�
data=[fault0,fault1,fault2,fault3,fault4,fault5,fault6,fault7,fault8,fault9,fault10,fault11,fault12];
disp('---data combine complete!');
%%
%�����������
input=data(2:end,:);
output=data(1,:);%��һ��Ϊ��ǩ
%��������������ȡ
n=randperm(num_train+num_test); 
%num_train������Ϊѵ������
input_train=input(:,n(1:num_train));                 
output_train=output(:,n(1:num_train));             
%ʣ��num_test������Ϊ��������
input_test=input(:,n((num_train+1):end));                
output_test=output(:,n((num_train+1):end));
disp('---data divide complete!');
%%
%������ȡ-��ȡͳ����
for j=1:num_train
    s1=input_train(:,j);
    tezheng=feature2(s1);
    ss1(:,j)=tezheng';
end
eigenvalue_train=ss1;

for j=1:num_test
    s2=input_test(:,j);
    tezheng=feature2(s2);
    ss2(:,j)=tezheng';
end
eigenvalue_test=ss2;
disp('---feature extraction complete!');
%%
%��Ԫ����
%����ȡ��2����������ʱ����PCA
[nx1,ny1]=size(eigenvalue_train');                         %eigenvalue_train'Ϊ500*32
[nx2,ny2]=size(eigenvalue_test');                          %eigenvalue_test'Ϊ280*32
eigenvalue=[eigenvalue_train';eigenvalue_test'];           %eigenvalueΪ280*32
Y=myPCA(eigenvalue);                                       %YΪ780*2����
Y1=Y(1:nx1,:);                                             %Y1Ϊ500*2����
Y2=Y(nx1+1:end,:);                                         %Y2Ϊ280*2����

eigenvalue_train1=Y1';                                     %eigenvalue_train1Ϊ2*500
eigenvalue_test1=Y2';                                      %eigenvalue_test1Ϊ2*280
disp('---feature selection complete!');
%%
%GridSearchѰ��
tic;
[bestacc,bestc,bestg]=SVMcgForClass(output_train',eigenvalue_train',-8,10,-10,8,5,1,1,4.5);
toc;
disp('Optimization complete!');
%%
%gaSVMcgForClass�Ŵ��㷨�����Ż�
tic;
ga_option.maxgen = 100;
ga_option.sizepop = 20;
ga_option.cbound = [0,1000];
ga_option.gbound = [0,100];
ga_option.v = 3;
ga_option.ggap = 0.5;
[BestCVaccuracy,bestc,bestg,ga_option] = gaSVMcgForClass(output_train',eigenvalue_train1',ga_option);
toc;
disp('Optimization complete!');
%%
%psoSVMcgForClass�����㷨����Ѱ��
tic;
[bestCVaccuracy,bestc,bestg]= psoSVMcgForClass(output_train',eigenvalue_train1')
toc;
disp('Optimization complete!');
%%
%libsvm
%model=svmtrain(output_train',eigenvalue_train','-c 200,-g 1');%c����4��ʱ��100%
%[predict_label, accuracy,prob_estimates] = svmpredict(output_test',eigenvalue_test',model);

cmd = ['-c ',num2str(bestc),'-g ',num2str(bestg)];
model=svmtrain(output_train',eigenvalue_train1',cmd);%c����4��ʱ��100%
[predict_label, accuracy,prob_estimates] = svmpredict(output_test',eigenvalue_test1',model);


%%
%%�������
%���Լ���ʵ�ʷ����Ԥ�����ͼ
%ͨ��ͼ���Կ���
figure(1);
hold on;
plot(output_test,'o');
plot(predict_label,'r*');
xlabel('���Լ�����','FontSize',12);
ylabel('����ǩ','FontSize',12);
legend('ʵ�ʲ��Լ�����','Ԥ����Լ�����');
title('���Լ���ʵ�ʷ����Ԥ�����ͼ','FontSize',12);
grid on;


%%
%�鿴��ȡ����ֵ�Ĳ���
figure(2);
hold on;
%for j=1:3
plot(output_train,Y1(:,1),'o');
plot(output_train,Y1(:,2),'+');
plot(output_train,Y1(:,3),'x');
%end;

%%
%�鿴��ȡ����ֵ�Ĳ���
figure(3);
hold on;
%for j=1:3
plot(output_train,ss1(1,:),'o');
plot(output_train,ss1(2,:),'+');
plot(output_train,ss1(3,:),'x');
plot(output_train,ss1(4,:),'*');
plot(output_train,ss1(5,:),'s');
plot(output_train,ss1(6,:),'d');
%end;