%pspice2data.m
function faultclass=pspice2data(path,row,column,order)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����:pspice���ݵ���matlab��classification
%����:path-���ݴ��·��
%-----rowҪ��ȡ������������ÿ�����ݲ�ͬ�������ָ��
%-----column������������������
%-----order���������ǩ�����ڼ���
%���:��һ�б�ǩ+��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pspicedata = importdata(path);
faultdata= pspicedata.data(1:row,2:end);
faultclass=[order*ones(1,column);faultdata];