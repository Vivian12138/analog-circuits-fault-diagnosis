%������ȡ
%20171020����p7-p10
function [shiyu]= feature2(x)

N = length(x);
%��������range
p1 = max(x)-min(x);
% ��ֵmean
p2 = mean(x);
% ��׼��std
p3 = std(x);
% ƫб��Skewness
p4 = skewness(x);
% �Ͷ�Kurtosis
p5 = kurtosis(x);
%��entropy
p6 = entropy(x);
%���ֵmax
p7 = max(x);
%��Сֵmin
p8 = max(x);
%������λ��
p9 = median(x);
%����3�����ľ�,E{[X-E(X)]^k}
p10=moment(x,3);
shiyu=[p1 p2 p3 p4 p5 p6 p7 p8 p9 p10];
%shiyu=[p2 p3 p5 p7 p10 p11];