%20170928_sallen_key.m
%ͳ����������ȡrange,mean,std,Skewness,Kurtosis,Entropy
%����ѵ������Ŀtrain1:9test
%%
tic;
clc;
clear;
%%
filename1='D:\pspice\20170926-SallenKey-MC\excel����\non-fault.xlsx';
filename2='D:\pspice\20170926-SallenKey-MC\excel����\c1+.xlsx';
filename3='D:\pspice\20170926-SallenKey-MC\excel����\c1-.xlsx';
filename4='D:\pspice\20170926-SallenKey-MC\excel����\c2+.xlsx';
filename5='D:\pspice\20170926-SallenKey-MC\excel����\c2-.xlsx';
filename6='D:\pspice\20170926-SallenKey-MC\excel����\r2+.xlsx';
filename7='D:\pspice\20170926-SallenKey-MC\excel����\r2-.xlsx';
filename8='D:\pspice\20170926-SallenKey-MC\excel����\r3+.xlsx';
filename9='D:\pspice\20170926-SallenKey-MC\excel����\r3-.xlsx';

sheet = 1;
xlRange = 'B2:CW137';
%��ȡexcel����
subset1 = xlsread(filename1,sheet,xlRange);%136*100
subset2 = xlsread(filename2,sheet,xlRange);
subset3 = xlsread(filename3,sheet,xlRange);
subset4 = xlsread(filename4,sheet,xlRange);
subset5 = xlsread(filename5,sheet,xlRange);
subset6 = xlsread(filename6,sheet,xlRange);
subset7 = xlsread(filename7,sheet,xlRange);
subset8 = xlsread(filename8,sheet,xlRange);
subset9 = xlsread(filename9,sheet,xlRange);
%%
%��һ����ӹ��ϱ���
fault1=[1*ones(1,100);subset1(1:136,1:100)];%137*100
fault2=[2*ones(1,100);subset2(1:136,1:100)];
fault3=[3*ones(1,100);subset3(1:136,1:100)];
fault4=[4*ones(1,100);subset4(1:136,1:100)];
fault5=[5*ones(1,100);subset5(1:136,1:100)];
fault6=[6*ones(1,100);subset6(1:136,1:100)];
fault7=[7*ones(1,100);subset7(1:136,1:100)];
fault8=[8*ones(1,100);subset8(1:136,1:100)];
fault9=[9*ones(1,100);subset9(1:136,1:100)];
%�ϲ�,50train50test
data(:,1:10)=fault1(:,1:10);%137*450
data(:,11:20)=fault2(:,1:10);
data(:,21:30)=fault3(:,1:10);
data(:,31:40)=fault4(:,1:10);
data(:,41:50)=fault5(:,1:10);
data(:,51:60)=fault6(:,1:10);
data(:,61:70)=fault7(:,1:10);
data(:,71:80)=fault8(:,1:10);
data(:,81:90)=fault9(:,1:10);
%�����������
test(:,1:90)=fault1(:,11:100);%137*450
test(:,91:180)=fault2(:,11:100);
test(:,181:270)=fault3(:,11:100);
test(:,271:360)=fault4(:,11:100);
test(:,361:450)=fault5(:,11:100);
test(:,451:540)=fault6(:,11:100);
test(:,541:630)=fault7(:,11:100);
test(:,631:720)=fault8(:,11:100);
test(:,721:810)=fault9(:,11:100);
%�����������
input_train=data(2:137,:);%inputΪ136*450
output_train=data(1,:);%��һ��

input_test=test(2:137,:);%inputΪ136*450
output_test=test(1,:);%��һ��

%%
%������ȡ
for j=1:90
    s1=input_train(:,j);
    tezheng=feature2(s1);
    ss1(:,j)=tezheng';%5*450
end
eigenvalue_train=ss1;

for j=1:810
    s2=input_test(:,j);
    tezheng=feature2(s2);
    ss2(:,j)=tezheng';%5*450
end
eigenvalue_test=ss2;
%%
%��Ԫ����

[nx1,ny1]=size(eigenvalue_train');                         %eigenvalue_train'Ϊ500*32
[nx2,ny2]=size(eigenvalue_test');                          %eigenvalue_test'Ϊ280*32
eigenvalue=[eigenvalue_train';eigenvalue_test'];           %eigenvalueΪ280*32
Y=myPCA(eigenvalue);                                       %YΪ780*2����
Y1=Y(1:nx1,:);                                             %Y1Ϊ500*2����
Y2=Y(nx1+1:end,:);                                         %Y2Ϊ280*2����

eigenvalue_train1=Y1';                                     %eigenvalue_train1Ϊ2*500
eigenvalue_test1=Y2';                                      %eigenvalue_test1Ϊ2*280
%%
%libsvm
model=svmtrain(output_train',eigenvalue_train1','-t 2 -c 100 -g 1');
[predict_label, accuracy, dec_values] = svmpredict(output_test',eigenvalue_test1',model);

toc;

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
plot(output_train,Y1(:,3),'*');
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