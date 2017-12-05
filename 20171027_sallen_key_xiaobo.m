%20170928_sallen_key.m
%5��С����+PCA+svm
%����ѵ������Ŀtrain1:9test
%���ѡȡ����,��С������82%
%%
clc;
clear;
disp('start~');
%%
num_train=300;
num_test=600;
%%
filename1='D:\pspice result\20170926-SallenKey-MC\excel����\non-fault.xlsx';
filename2='D:\pspice result\20170926-SallenKey-MC\excel����\c1+.xlsx';
filename3='D:\pspice result\20170926-SallenKey-MC\excel����\c1-.xlsx';
filename4='D:\pspice result\20170926-SallenKey-MC\excel����\c2+.xlsx';
filename5='D:\pspice result\20170926-SallenKey-MC\excel����\c2-.xlsx';
filename6='D:\pspice result\20170926-SallenKey-MC\excel����\r2+.xlsx';
filename7='D:\pspice result\20170926-SallenKey-MC\excel����\r2-.xlsx';
filename8='D:\pspice result\20170926-SallenKey-MC\excel����\r3+.xlsx';
filename9='D:\pspice result\20170926-SallenKey-MC\excel����\r3-.xlsx';

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
disp('data import end')
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
data(:,1:100)=fault1;%137*900
data(:,101:200)=fault2;
data(:,201:300)=fault3;
data(:,301:400)=fault4;
data(:,401:500)=fault5;
data(:,501:600)=fault6;
data(:,601:700)=fault7;
data(:,701:800)=fault8;
data(:,801:900)=fault9;

%%
%�����������
input=data(2:end,:);%inputΪ136*450
output=data(1,:);%��һ��
%���������
n=randperm(num_train+num_test); 
%500������Ϊѵ������
input_train=input(:,n(1:num_train));                 %input_trainΪ136*500����;ÿһ�д���һ������
output_train=output(:,n(1:num_train));              %output_trainΪ1*500����
%ʣ��400������Ϊ��������
input_test=input(:,n((num_train+1):end));                %input_testΪ136*400����
output_test=output(:,n((num_train+1):end));             %output_testΪ1*400����
%%
%5��С����+����
ss1=zeros(2^5,num_train); 
 for j=1:num_train
    s1=input_train(:,j);
    %��db1С�������ź�s1����5��ֽ�
    t=wpdec(s1,5,'db3','shannon');
    %����������źŵ������ϵ�������ع�
    s1_0=wprcoef(t,[5,0]);                      %s1_0Ϊ210*1
    s1_1=wprcoef(t,[5,1]);                      %s1_1Ϊ210*1
    s1_2=wprcoef(t,[5,2]);                      %s1_2Ϊ210*1
    s1_3=wprcoef(t,[5,3]);                      %s1_3Ϊ210*1
    s1_4=wprcoef(t,[5,4]);                      %s1_4Ϊ210*1
    s1_5=wprcoef(t,[5,5]);                      %s1_5Ϊ210*1
    s1_6=wprcoef(t,[5,6]);                      %s1_6Ϊ210*1
    s1_7=wprcoef(t,[5,7]);                      %s1_7Ϊ210*1
    s1_8=wprcoef(t,[5,8]);                      %s1_8Ϊ210*1
    s1_9=wprcoef(t,[5,9]);                      %s1_9Ϊ210*1
    s1_10=wprcoef(t,[5,10]);                    %s1_10Ϊ210*1
    s1_11=wprcoef(t,[5,11]);                    %s1_11Ϊ210*1
    s1_12=wprcoef(t,[5,12]);                    %s1_12Ϊ210*1
    s1_13=wprcoef(t,[5,13]);                    %s1_13Ϊ210*1
    s1_14=wprcoef(t,[5,14]);                    %s1_14Ϊ210*1
    s1_15=wprcoef(t,[5,15]);                    %s1_15Ϊ210*1
    s1_16=wprcoef(t,[5,16]);                    %s1_16Ϊ210*1 
    s1_17=wprcoef(t,[5,17]);                    %s1_17Ϊ210*1
    s1_18=wprcoef(t,[5,18]);                    %s1_18Ϊ210*1
    s1_19=wprcoef(t,[5,19]);                    %s1_19Ϊ210*1
    s1_20=wprcoef(t,[5,20]);                    %s1_20Ϊ210*1
    s1_21=wprcoef(t,[5,21]);                    %s1_21Ϊ210*1
    s1_22=wprcoef(t,[5,22]);                    %s1_22Ϊ210*1
    s1_23=wprcoef(t,[5,23]);                    %s1_23Ϊ210*1
    s1_24=wprcoef(t,[5,24]);                    %s1_24Ϊ210*1
    s1_25=wprcoef(t,[5,25]);                    %s1_25Ϊ210*1
    s1_26=wprcoef(t,[5,26]);                    %s1_26Ϊ210*1
    s1_27=wprcoef(t,[5,27]);                    %s1_27Ϊ210*1
    s1_28=wprcoef(t,[5,28]);                    %s1_28Ϊ210*1
    s1_29=wprcoef(t,[5,29]);                    %s1_29Ϊ210*1
    s1_30=wprcoef(t,[5,30]);                    %s1_30Ϊ210*1
    s1_31=wprcoef(t,[5,31]);                    %s1_31Ϊ210*1
  
    %����С����-�����أ���ȡ����������(����С������������SVM��ģ���·�������)
    S1=[s1_0 s1_1 s1_2 s1_3 s1_4 s1_5 s1_6 s1_7 s1_8 s1_9 s1_10 s1_11 s1_12 s1_13 s1_14 s1_15 s1_16 s1_17 s1_18 s1_19 s1_20 s1_21 s1_22 s1_23 s1_24 s1_25 s1_26 s1_27 s1_28 s1_29 s1_30 s1_31 ];
    %S1Ϊ210*32
    for jj=1:32
        S11=S1(:,jj);
        E1=S11.^2;
        E=sum(S11.^2);
        e1=E1./E;
        H(:,jj)=-sum(e1.*log10(e1));
    end
    ss1(:,j)=H;
 end
    
eigenvalue_train=ss1 ;                                         %eigenvalue_trainΪ32*500����ѵ����������ֵ
%%
ss2=zeros(2^5,num_test);
for j=1:num_test
    s2=input_test(:,j);
    %��db1С�������ź�s1��������ֽ�
    t=wpdec(s2,5,'db3','shannon');
    %����������źŵ������ϵ�������ع�
    s2_0=wprcoef(t,[5,0]);                                     %s2_0Ϊ210*1 
    s2_1=wprcoef(t,[5,1]);                                     %s2_1Ϊ210*1
    s2_2=wprcoef(t,[5,2]);                                     %s2_2Ϊ210*1
    s2_3=wprcoef(t,[5,3]);                                     %s2_3Ϊ210*1
    s2_4=wprcoef(t,[5,4]);                                     %s2_4Ϊ210*1
    s2_5=wprcoef(t,[5,5]);                                     %s2_5Ϊ210*1
    s2_6=wprcoef(t,[5,6]);                                     %s2_6Ϊ210*1
    s2_7=wprcoef(t,[5,7]);                                     %s2_7Ϊ210*1
    s2_8=wprcoef(t,[5,8]);                                     %s2_8Ϊ210*1
    s2_9=wprcoef(t,[5,9]);                                     %s2_9Ϊ210*1  
    s2_10=wprcoef(t,[5,10]);                                   %s2_10Ϊ210*1
    s2_11=wprcoef(t,[5,11]);                                   %s2_11Ϊ210*1
    s2_12=wprcoef(t,[5,12]);                                   %s2_12Ϊ210*1
    s2_13=wprcoef(t,[5,13]);                                   %s2_13Ϊ210*1
    s2_14=wprcoef(t,[5,14]);                                   %s2_14Ϊ210*1
    s2_15=wprcoef(t,[5,15]);                                   %s2_15Ϊ210*1
    s2_16=wprcoef(t,[5,16]);                                   %s2_16Ϊ210*1
    s2_17=wprcoef(t,[5,17]);                                   %s2_17Ϊ210*1
    s2_18=wprcoef(t,[5,18]);                                   %s2_18Ϊ210*1
    s2_19=wprcoef(t,[5,19]);                                   %s2_19Ϊ210*1
    s2_20=wprcoef(t,[5,20]);                                   %s2_20Ϊ210*1
    s2_21=wprcoef(t,[5,21]);                                   %s2_21Ϊ210*1
    s2_22=wprcoef(t,[5,22]);                                   %s2_22Ϊ210*1
    s2_23=wprcoef(t,[5,23]);                                   %s2_23Ϊ210*1
    s2_24=wprcoef(t,[5,24]);                                   %s2_24Ϊ210*1
    s2_25=wprcoef(t,[5,25]);                                   %s2_25Ϊ210*1
    s2_26=wprcoef(t,[5,26]);                                   %s2_26Ϊ210*1
    s2_27=wprcoef(t,[5,27]);                                   %s2_27Ϊ210*1
    s2_28=wprcoef(t,[5,28]);                                   %s2_28Ϊ210*1
    s2_29=wprcoef(t,[5,29]);                                   %s2_29Ϊ210*1
    s2_30=wprcoef(t,[5,30]);                                   %s2_30Ϊ210*1
    s2_31=wprcoef(t,[5,31]);                                   %s2_31Ϊ210*1  
    
    %����С����-�����أ���ȡ����������(����С������������SVM��ģ���·�������)
    S2=[s2_0 s2_1 s2_2 s2_3 s2_4 s2_5 s2_6 s2_7 s2_8 s2_9 s2_10 s2_11 s2_12 s2_13 s2_14 s2_15 s2_16 s2_17 s2_18 s2_19 s2_20 s2_21 s2_22 s2_23 s2_24 s2_25 s2_26 s2_27 s2_28 s2_29 s2_30 s2_31 ];
    %S2Ϊ210*32
    for jj=1:32
        S22=S2(:,jj);
        E2=S22.^2;
        E=sum(S22.^2);
        e2=E2./E;
        H(:,jj)=-sum(e2.*log10(e2));
    end
    ss2(:,j)=H;
end
eigenvalue_test=ss2 ;                            %eigenvalue_testΪ32*280���󣬲��Լ�����ֵ
disp('feature extraction complete!');
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
disp('feature selection complete!');
%%
%GridSearchѰ��
tic
[bestacc_1,bestc_1,bestg_1]=SVMcgForClass(output_train',eigenvalue_train1',-1,3,-1,3,5,0.1,0.1,4.5);
toc
disp('GridSearch Optimization complete!');
%%
%gaSVMcgForClass�Ŵ������Ż�
ga_option.maxgen = 20;
ga_option.sizepop = 20;
ga_option.ggap = 0.5;
ga_option.cbound = [10^(-1),10^3];
ga_option.gbound = [10^(-2),10^3];
ga_option.v = 5;

tic
[bestacc_2,bestc_2,bestg_2] = gaSVMcgForClass(output_train',eigenvalue_train1',ga_option);
toc
disp('GA Optimization complete!');
%%
%psoSVMcgForClass����Ѱ��
pso_option.c1 = 1.5;
pso_option.c2 = 1.7;
pso_option.maxgen = 20;
pso_option.sizepop = 20;
pso_option.k = 0.6;
pso_option.wV = 1;
pso_option.wP = 1;
pso_option.v = 5;
pso_option.popcmax = 1000;
pso_option.popcmin = 0.1;
pso_option.popgmax = 1000;
pso_option.popgmin = 0.01;

tic
[bestacc_3,bestc_3,bestg_3]= psoSVMcgForClass(output_train',eigenvalue_train1',pso_option);
toc
disp('PSO Optimization complete!');
%%
%scaSVMcgForClass����Ѱ��
sca_option.maxgen=20;
sca_option.sizepop=20;
sca_option.v=5;
sca_option.popcmax=10^3;
sca_option.popcmin=10^(-1);
sca_option.popgmax=10^3;
sca_option.popgmin=10^(-2);

tic
[bestacc_4,bestc_4,bestg_4]= scaSVMcgForClass(output_train',eigenvalue_train1',sca_option);
toc
disp('SCA Optimization complete!');
%%
%libsvm
model=svmtrain(output_train',eigenvalue_train1');%c����4��ʱ��100%
[predict_label, accuracy_0,prob_estimates] = svmpredict(output_test',eigenvalue_test1',model);

cmd = ['-c ',num2str(bestc_1),' -g ',num2str(bestg_1)];
model=svmtrain(output_train',eigenvalue_train1',cmd);%c����4��ʱ��100%
[predict_label,accuracy_1,prob_estimates] = svmpredict(output_test',eigenvalue_test1',model);

cmd = ['-c ',num2str(bestc_2),' -g ',num2str(bestg_2)];
model=svmtrain(output_train',eigenvalue_train1',cmd);%c����4��ʱ��100%
[predict_label,accuracy_2,prob_estimates] = svmpredict(output_test',eigenvalue_test1',model);

cmd = ['-c ',num2str(bestc_3),' -g ',num2str(bestg_3)];
model=svmtrain(output_train',eigenvalue_train1',cmd);%c����4��ʱ��100%
[predict_label,accuracy_3,prob_estimates] = svmpredict(output_test',eigenvalue_test1',model);

cmd = ['-c ',num2str(bestc_4),' -g ',num2str(bestg_4)];
model=svmtrain(output_train',eigenvalue_train1',cmd);%c����4��ʱ��100%
[predict_label,accuracy_4,prob_estimates] = svmpredict(output_test',eigenvalue_test1',model);

bestacc_1,bestacc_2,bestacc_3,bestacc_4
%%
%���roc����ʱ����bΪ1
cmd = ['-c ',num2str(bestc_4),' -g ',num2str(bestg_4),' -b 1'];
model=svmtrain(output_train',eigenvalue_train1',cmd);%c����4��ʱ��100%
[predict_label, accuracy,decision_values] = svmpredict(output_test',eigenvalue_test1',model,'-b 1');
plotSVMroc(output_test',decision_values,9)
% %���������
% type = 2;
% CR = ClassResult(output_test',eigenvalue_test1',model,type)
%%
%%�������
%���Լ���ʵ�ʷ����Ԥ�����ͼ
%ͨ��ͼ���Կ���
figure;
hold on;
plot(output_test,'o');
plot(predict_label,'r*');
xlabel('���Լ�����','FontSize',12);
ylabel('����ǩ','FontSize',12);
legend('ʵ�ʲ��Լ�����','Ԥ����Լ�����');
%title('���Լ���ʵ�ʷ����Ԥ�����ͼ','FontSize',12);
grid on;
box on;
