%������ȡ
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
shiyu=[p1 p2 p3 p4 p5 p6];
%shiyu=[p2 p3 p5 p7 p10 p11];