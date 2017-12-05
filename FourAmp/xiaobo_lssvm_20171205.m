%20170928_sallen_key.m
%5��С����+PCA+svm
%���ѡȡ����,��С������82%
%%
tic;
clc;
clear;
disp('---start~');
%%
num_fault=13;%0-12
num_column=100;%����������
num_all=num_fault*num_column;%������������
num_row=532;%����������ά��
num_train=num_all/2;
num_test=num_all-num_train;
%%
%���ݵ��벢��ӷ����ǩ
fault0 = pspice2data('D:\matlab\FourAmp\data\f0.txt',num_row,num_column,0);
fault1 = pspice2data('D:\matlab\FourAmp\data\f1.txt',num_row,num_column,1);
fault2 = pspice2data('D:\matlab\FourAmp\data\f2.txt',num_row,num_column,2);
fault3 = pspice2data('D:\matlab\FourAmp\data\f3.txt',num_row,num_column,3);
fault4 = pspice2data('D:\matlab\FourAmp\data\f4.txt',num_row,num_column,4);
fault5 = pspice2data('D:\matlab\FourAmp\data\f5.txt',num_row,num_column,5);
fault6 = pspice2data('D:\matlab\FourAmp\data\f6.txt',num_row,num_column,6);
fault7 = pspice2data('D:\matlab\FourAmp\data\f7.txt',num_row,num_column,7);
fault8 = pspice2data('D:\matlab\FourAmp\data\f8.txt',num_row,num_column,8);
fault9 = pspice2data('D:\matlab\FourAmp\data\f9.txt',num_row,num_column,9);
fault10 = pspice2data('D:\matlab\FourAmp\data\f10.txt',num_row,num_column,10);
fault11 = pspice2data('D:\matlab\FourAmp\data\f11.txt',num_row,num_column,11);
fault12 = pspice2data('D:\matlab\FourAmp\data\f12.txt',num_row,num_column,12);
disp('---data import complete!');
%%
%���ݺϲ�
data=[fault0,fault1,fault2,fault3,fault4,fault5,fault6,fault7,fault8,fault9,fault10,fault11,fault12];
disp('---data combine complete!');
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
 for j=1:num_train
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

for j=1:num_test
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
%% lssvm
t1=cputime;
model = initlssvm(eigenvalue_train1',output_train','c',[],[],'RBF_kernel','orignal');
model = tunelssvm(model,'simplex','crossvalidatelssvm',{10,'misclass'},'code_OneVsOne');
model = trainlssvm(model);
output_predict = simlssvm(model,eigenvalue_test1');
output_predict=output_predict';
t2=cputime;
fprintf(1,'Tuning time %i \n',t2-t1);
fprintf(1,'Accuracy: %2.2f\n',100*sum(output_predict==output_test)/length(output_test));
plotlssvm(model,[],150);

%% LS��������
type = 'c';
kernel_type = 'RBF_kernel';
codefct = 'code_OneVsOne'; 
preprocess = 'preprocess';%'preprocess'����'original'
% igam=0.1;
% isig2=0.1;
% %�������ࡱת���ɡ����ࡱ�ı��뷽��
% 1. Minimum Output Coding (code_MOC) 
% 2. Error Correcting Output Code (code_ECOC)
% 3. One versus All Coding (code_OneVsAll)
% 4. One Versus One Coding (code_OneVsOne) 
t1=cputime;
% PSO��֤�Ż�����
[bestCVaccuarcy,bestc,bestg,pso_option] = psoLSSVMcgForClass(eigenvalue_train1',output_train');

% ����
[Yc,codebook,old_codebook] = code(output_train',codefct);
% ѵ������ģ��
[alpha,b]=trainlssvm({eigenvalue_train1',Yc,type,bestc,bestg,kernel_type});
%���������
Yd = simlssvm({eigenvalue_train1',Yc,type,bestc,bestg,kernel_type},{alpha,b},eigenvalue_test1');
output_predict = code(Yd,old_codebook,[],codebook);%���������
output_predict=output_predict';
t2=cputime;
fprintf(1,'Tuning time %i \n',t2-t1);
fprintf(1,'Accuracy: %2.2f\n',100*sum(output_predict==output_test)/length(output_test));
plotlssvm(model,[],150);

%%
%%�������
%���Լ���ʵ�ʷ����Ԥ�����ͼ
%ͨ��ͼ���Կ���
figure;
hold on;
plot(output_test,'o');
plot(output_predict,'r*');
xlabel('���Լ�����','FontSize',12);
ylabel('����ǩ','FontSize',12);
legend('ʵ�ʲ��Լ�����','Ԥ����Լ�����');
%title('���Լ���ʵ�ʷ����Ԥ�����ͼ','FontSize',12);
grid on;
box on;