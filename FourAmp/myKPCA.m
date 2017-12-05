function [eigvector, eigvalue,Y] = myKPCA(X,r,opts)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kernel Principal Component Analysis
% [eigvector, eigvalue,Y] = KPCA(X,r,opts)
% Input:
% X: d*N data matrix;Each column vector of X is a sample vector.
% r: Dimensionality of reduced space (default: d)
% opts:   Struct value in Matlab. The fields in options that can be set:           
%         KernelType  -  Choices are:
%                  'Gaussian'      - exp{-gamma(|x-y|^2)}
%                  'Polynomial'    - (x'*y)^d
%                  'PolyPlus'      - (x'*y+1)^d
%         gamma       -  parameter for Gaussian kernel
%         d           -  parameter for polynomial kernel
%
% Output:
% eigvector: N*r matrix;Each column is an embedding function, for a new
%            data point (column vector) x,  y = eigvector'*K(x,:)'
%            will be the embedding result of x.
%            K(x,:) = [K(x1,x),K(x2,x),...K(xN,x)]
% eigvalue: The sorted eigvalue of KPCA eigen-problem.
% Y       : Data matrix after the nonlinear transform

if nargin<1
  error('Not enough input arguments.')
end
[d,N]=size(X);
if nargin<2
  r=d;
end
%% Ensure r is not bigger than d
if r>d
    r=d;
end;
% Construct the Kernel matrix K
K =ConstructKernelMatrix(X,[],opts);
% Centering kernel matrix
One_N=ones(N)./N;
Kc = K - One_N*K - K*One_N + One_N*K*One_N;         %Kc���K������ȥ��ֵ��Ҫ��
clear One_N;
% Solve the eigenvalue problem N*lamda*alpha = K*alpha
if N>1000 && r
    % using eigs to speed up!
    opts.disp=0;
    [eigvector, eigvalue] = eigs(Kc,r,'la',opts);   %��Kc������ֵ����������������'la'��ʾ�������ֵ��r��ʾ����ֵ�ĸ���
    eigvalue = diag(eigvalue);                      %�õ�����ֵ��������
else
    [eigvector, eigvalue] = eig(Kc);                %��Kc������ֵ����������                               
    eigvalue = diag(eigvalue);                      %�õ�����ֵ��������
    [junk, index] = sort(-eigvalue);                %����sortһ���Ǵ�С��������ȡ����Ŀ���ǵõ��Ӵ�С������             
    eigvalue = eigvalue(index);                     %���Ӵ�С��������ֵ
    eigvector = eigvector(:,index);                 %������ֵ��Ӧ������������
end
if r < length(eigvalue)
    eigvalue = eigvalue(1:r);
    eigvector = eigvector(:,1:r);
end
% Only reserve the eigenvector with nonzero eigenvalues������������ֵ��Ӧ����������
maxEigValue = max(abs(eigvalue));                   %ȡ����ֵ��������ֵ
eigIdx = find(abs(eigvalue)/maxEigValue < 1e-6);    %�ҵ�����ֵ����ֵ���������ֵ֮��С��1e-6������ֵ������
eigvalue (eigIdx) = [];                             %���ҵ�������ֵ����ֵ
eigvector (:,eigIdx) = [];                          %���ҵ�������ֵ��Ӧ��������������ֵ

% Normalizing eigenvector��һ����������
% for i=1:m
for i=1:length(eigvalue)
    eigvector(:,i)=eigvector(:,i)/sqrt(eigvalue(i));
end;
%%%%%%%%%%%
%�Ҽӵĳ���
% sum_latent=sum(eigvalue);
% temp=0;
% con=0;
% m=0;
% for i=1:d
%     if con<0.8
%         temp=temp+eigvalue(i);
%         con=temp/sum_latent;
%         m=m+1;
%     else
%         break;
%     end
% end
% eigvector(:,m+1:d)=[];
%%%%%%%%%%%%


if nargout >= 3
    % Projecting the data in lower dimensions
    Y = eigvector'*K;
end
 
function K=ConstructKernelMatrix(X,Y,opts)
%
% function K=ConstructKernelMatrix(X,Y,opts)
% Usage:
%   opts.KernelType='Gaussian';
% K = ConstructKernelMatrix(X,[],opts)
%   K = ConstructKernelMatrix(X,Y,opts)
%
% Input:
% X: d*N data matrix;Each column vector of X is a sample vector.
% Y: d*M data matrix;Each column vector of Y is a sample vector.
% opts:   Struct value in Matlab. The fields in options that can be set:                
%         KernelType  -  Choices are:
%                  'Gaussian'      - exp{-gamma(|x-y|^2)}
%                  'Polynomial'    - (x'*y)^d
%                  'PolyPlus'      - (x'*y+1)^d
%         gamma       -  parameter for Gaussian kernel
%         d           -  parameter for polynomial kernel
% Output:
% K N*N or N*M matrix
if nargin<1
  error('Not enough input arguments.')
end
if (~exist('opts','var'))        %��opts�����Ƿ���ڣ���������������¸�ֵ
   opts = [];
else
   if ~isstruct(opts)            %���opts���ǽṹ�壬����ʾ����
       error('parameter error!');
   end
end
N=size(X,2);
if isempty(Y)     %���Y�ǿգ���ִ������
    K=zeros(N,N);
else
    M=size(Y,2);                 %����Y������
    if size(X,1)~=size(Y,1)      %��������    
        error('Matrixes X and Y should have the same row dimensionality!');
    end;
    K=zeros(N,M);
end;
%=================================================
if ~isfield(opts,'KernelType')                 
    opts.KernelType = 'Gaussian';   
end
switch lower(opts.KernelType)
    case {lower('Gaussian')}        %  exp{-gamma(|x-y|^2)}
        if ~isfield(opts,'gamma')
            opts.gamma = 0.5;
        end
    case {lower('RBF')}
        if ~isfield(opts,'gamma')
            opts.gamma = 10;
        end
    case {lower('Polynomial')}      % (x'*y)^d
        if ~isfield(opts,'d')
            opts.d = 1;
        end
    case {lower('PolyPlus')}      % (x'*y+1)^d
        if ~isfield(opts,'d')
            opts.d = 1;
        end
    case {lower('tanh')}          
        if ~isfield(opts,'g')||~isfield(opts,'c')
            opts.g = 1;
            opts.c = 1;
        end
    otherwise
       error('KernelType does not exist!');
end
switch lower(opts.KernelType)       %����ĸתΪСд
    case {lower('Gaussian')}        %����ĸתΪСд     
        if isempty(Y)               %��Y�ǲ��ǿվ����������ִ���������
            for i=1:N
               for j=i:N
%                    dist = sum(((X(:,i) - X(:,j)).^2));
                    dist = norm(X(:,i) - X(:,j)) .^2;
                    temp=exp(-opts.gamma*dist);
                    K(i,j)=temp;
                    if i~=j
                        K(j,i)=temp;
                    end;
                end
            end
        else
            for i=1:N
               for j=1:M
%                     dist = sum(((X(:,i) - Y(:,j)).^2));
                    dist =norm(X(:,i) - Y(:,j)).^2;
                    K(i,j)=exp(-opts.gamma*dist);                  
                end
            end
        end      
    case {lower('Polynomial')}    
        if isempty(Y)
            for i=1:N
                for j=i:N                   
                    temp=(X(:,i)'*X(:,j))^opts.d;
                    K(i,j)=temp;
                    if i~=j
                        K(j,i)=temp;
                    end;
                end
            end
        else
            for i=1:N
                for j=1:M                                      
                    K(i,j)=(X(:,i)'*Y(:,j))^opts.d;
                end
            end
        end      
    case {lower('PolyPlus')}    
        if isempty(Y)
            for i=1:N
                for j=i:N                   
                    temp=(X(:,i)'*X(:,j)+1)^opts.d;
                    K(i,j)=temp;
                    if i~=j
                        K(j,i)=temp;
                    end;
                end
            end
        else
            for i=1:N
                for j=1:M                                      
                    K(i,j)=(X(:,i)'*Y(:,j)+1)^opts.d;
                end
            end
        end
    case {lower('RBF')}      
        if isempty(Y)
            for i=1:N
                for j=i:N
%                     dist = sum(((X(:,i) - X(:,j)).^2));
                    dist = norm(X(:,i) - X(:,j)).^2;
%                     temp=exp(-0.5*dist/opts.gamma^2);
                    temp=exp(-10*dist/opts.gamma^2);
                    K(i,j)=temp;
                    if i~=j
                        K(j,i)=temp;
                    end;
                end
            end
        else
            for i=1:N
                for j=1:M
%                     dist = sum(((X(:,i) - Y(:,j)).^2));
                    dist = norm(X(:,i) - Y(:,j)).^2;
%                     K(i,j)=exp(-0.5*dist/opts.gamma^2);
                     K(i,j)=exp(-10*dist/opts.gamma^2);
                end
            end
        end      
    case {lower('tanh')}
         if isempty(Y)
            for i=1:N
                for j=i:N                   
                    temp=opts.g*X(:,i)*X(:,j)'+opts.c;
                    K(i,j)=temp;
                    if i~=j
                        K(j,i)=temp;
                    end
                end
            end
        else
            for i=1:N
                for j=1:M                                      
                    K(i,j)=opts.g*X(:,i)*Y(:,j)'+opts.c;
                end
            end 
        end      
    otherwise
        error('KernelType does not exist!');
end
