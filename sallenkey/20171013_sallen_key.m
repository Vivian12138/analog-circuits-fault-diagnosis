%20170928_sallen_key.m
%5��С����+svm
tic;
clc all
clear;

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
subset1 = xlsread(filename1,sheet,xlRange);
subset2 = xlsread(filename2,sheet,xlRange);
subset3 = xlsread(filename3,sheet,xlRange);
subset4 = xlsread(filename4,sheet,xlRange);
subset5 = xlsread(filename5,sheet,xlRange);
subset6 = xlsread(filename6,sheet,xlRange);
subset7 = xlsread(filename7,sheet,xlRange);
subset8 = xlsread(filename8,sheet,xlRange);
subset9 = xlsread(filename9,sheet,xlRange);
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
data(:,1:50)=fault1(:,1:50);%137*900
data(:,51:100)=fault2(:,1:50);
data(:,101:150)=fault3(:,1:50);
data(:,151:200)=fault4(:,1:50);
data(:,201:250)=fault5(:,1:50);
data(:,251:300)=fault6(:,1:50);
data(:,301:350)=fault7(:,1:50);
data(:,351:400)=fault8(:,1:50);
data(:,401:450)=fault9(:,1:50);
%�����������
test(:,1:50)=fault1(:,51:100);%137*900
test(:,51:100)=fault2(:,51:100);
test(:,101:150)=fault3(:,51:100);
test(:,151:200)=fault4(:,51:100);
test(:,201:250)=fault5(:,51:100);
test(:,251:300)=fault6(:,51:100);
test(:,301:350)=fault7(:,51:100);
test(:,351:400)=fault8(:,51:100);
test(:,401:450)=fault9(:,51:100);
%�����������
input_train=data(2:137,:);%inputΪ136*390
output_train=data(1,:);%��һ��

input_test=test(2:137,:);%inputΪ136*390
output_test=test(1,:);%��һ��
 for j=1:450
    s1=input_train(:,j);
    %��db1С�������ź�s1����5��ֽ�
    t=wpdec(s1,5,'db1','shannon');
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
  
    %��������źŸ��ع�ϵ���ķ���
    %���������źŸ��ع�ϵ���ķ���
    s10=norm(s1_0);
    s11=norm(s1_1);
    s12=norm(s1_2);
    s13=norm(s1_3);
    s14=norm(s1_4);
    s15=norm(s1_5);
    s16=norm(s1_6);
    s17=norm(s1_7);
    s18=norm(s1_8);
    s19=norm(s1_9);
    s110=norm(s1_10);
    s111=norm(s1_11);
    s112=norm(s1_12);
    s113=norm(s1_13);
    s114=norm(s1_14);
    s115=norm(s1_15);
    s116=norm(s1_16);
    s117=norm(s1_17);
    s118=norm(s1_18);
    s119=norm(s1_19);
    s120=norm(s1_20);
    s121=norm(s1_21);
    s122=norm(s1_22);
    s123=norm(s1_23);
    s124=norm(s1_24);
    s125=norm(s1_25);
    s126=norm(s1_26);
    s127=norm(s1_27);
    s128=norm(s1_28);
    s129=norm(s1_29);
    s130=norm(s1_30);
    s131=norm(s1_31);             
    %����ss1������ź�s1���������
    ss1(:,j)=[s10;s11;s12;s13;s14;s15;s16;s17;s18;s19;s110;s111;s112;s113;s114;s115;s116;s117;s118;s119;s120;s121;s122;s123;s124;s125;s126;s127;s128;s129;s130;s131];
end
eigenvalue_train=ss1 ;                                         %eigenvalue_trainΪ32*500����ѵ����������ֵ
% ss2=zeros(8,90);                              %ss2�洢c���Ե�С����������������8*190
for j=1:450
    s2=input_test(:,j);
    %��db1С�������ź�s1��������ֽ�
    t=wpdec(s2,5,'db1','shannon');
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
    
    %���������źŸ��ع�ϵ���ķ���
    s20=norm(s2_0);
    s21=norm(s2_1);
    s22=norm(s2_2);
    s23=norm(s2_3);
    s24=norm(s2_4);
    s25=norm(s2_5);
    s26=norm(s2_6);
    s27=norm(s2_7);
    s28=norm(s2_8);
    s29=norm(s2_9);
    s210=norm(s2_10);
    s211=norm(s2_11);
    s212=norm(s2_12);
    s213=norm(s2_13);
    s214=norm(s2_14);
    s215=norm(s2_15);
    s216=norm(s2_16);
    s217=norm(s2_17);
    s218=norm(s2_18);
    s219=norm(s2_19);
    s220=norm(s2_20);
    s221=norm(s2_21);
    s222=norm(s2_22);
    s223=norm(s2_23);
    s224=norm(s2_24);
    s225=norm(s2_25);
    s226=norm(s2_26);
    s227=norm(s2_27);
    s228=norm(s2_28);
    s229=norm(s2_29);
    s230=norm(s2_30);
    s231=norm(s2_31);
    %����ss2������ź�s2���������
    ss2(:,j)=[s20;s21;s22;s23;s24;s25;s26;s27;s28;s29;s210;s211;s212;s213;s214;s215;s216;s217;s218;s219;s220;s221;s222;s223;s224;s225;s226;s227;s228;s229;s230;s231];
end
eigenvalue_test=ss2 ;                            %eigenvalue_testΪ32*280���󣬲��Լ�����ֵ
%%
%libsvm
model=svmtrain(output_train',eigenvalue_train','-c 4,-g 1');%c����4��ʱ��100%
[predict_label, accuracy, dec_values] = svmpredict(output_test',eigenvalue_test',model);

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
plot(output_train,Y1(:,4),'x');
%end;

%�鿴��ȡ����ֵ�Ĳ���
figure(3);
hold on;
for j=1:32
    plot(output_train,ss1(j,:),'o');
end;