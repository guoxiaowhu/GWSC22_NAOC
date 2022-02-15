function RandVec = customrand(a,b,N)
% generate trial values from uniform distribution U(a,b)
RandVec = (b-a)*rand(1,N) + a;
end