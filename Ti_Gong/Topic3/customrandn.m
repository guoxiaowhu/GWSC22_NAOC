function RandnVec = customrandn(a,b,N)
% generate trial values from normal distribution N(a,b)
RandnVec = b*randn(1,N) + a;
end