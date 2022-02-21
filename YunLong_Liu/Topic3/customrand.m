function U=customrand(N,M,a,b)
% 生成随机数
% U=customrand(N,M,a,b)
% 输出随机数矩阵U. 输入随机数矩阵行列数N,M
% 输入随机数概率密度分布参数 a,b
% 1/(b-a) a<x<b
% 0 otherwise

U0=rand(N,M);
U=(b-a)*U0+a;

