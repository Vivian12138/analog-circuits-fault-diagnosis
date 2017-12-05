%%
%�ź�������ȡ16��ʱ��Ƶ��ָ�� ��ֵ����׼���� ƫб��ָ�ꡢ�Ͷ�ָ�ꡢ ��-��ֵ����ֵ��������ֵ��ƽ����ֵ��������ֵ������ָ�ꡢ��ֵָ��
%(Signal feature extraction 16 time domain, frequency domain mean, standard deviation, variance, skewness index, kurtosis index, peak- peak, mean square amplitude, average amplitude, square root amplitude, waveform indicators Peak Indicators)
%%
function u=tezhengtiqu16(r)
u=[];
for i=1:1:30
a=r(486*(i-1)+1:486*i,1);  %729*9
s=a;
u1=mean(s); % ��ֵ
s=s-u1;
u2=std(s);% ��׼��
u3=var(s); % ����
u4=skewness(s); % ƫб��ָ��
u5=kurtosis(s); % �Ͷ�ָ��
u6=max(s)-min(s); % ��-��ֵ
Xp=max(max(s), -min(s)); %��ֵ
Xrms=sqrt(mean(s.*s)); % ������ֵ
Xmean=mean(abs(s)); %ƽ����ֵ
Xr=mean(sqrt(abs(s)))*mean(sqrt(abs(s))); % ������ֵ
u7=Xrms/Xmean; %����ָ��
u8=Xp/Xrms; % ��ֵָ�ꡢ����ָ�ꡢԣ��ָ�ꡢ����Ƶ�ʡ�Ƶ�ʷ��8��С����������
u9=Xp/Xmean;%����ָ�ꡢ
u10=Xp/Xr;% ԣ��ָ��
%��ֵ����׼���� ƫб��ָ�ꡢ�Ͷ�ָ�ꡢ ��-��ֵ����ֵ��������ֵ��ƽ����ֵ��������ֵ������ָ�ꡢ��ֵָ��
uu=[u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,Xp,Xrms,Xmean,Xr];
u=cat(1,u,uu);
end
u;