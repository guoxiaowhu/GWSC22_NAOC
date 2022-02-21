function U=customrandn(N,M,a,b)
% 生成随机数
% U=customrandn(N,M,a,b)
% 输出随机数矩阵U. 输入随机数矩阵行列数N,M
% 输入随机数概率密度分布参数 a b
% 1/(sqrt(2 pi) a) exp(-(x-b)^2/(2*a^2)) 
U0=randn(N,M);
U=a*U0+b;

