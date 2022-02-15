N = 10000;
uVec = customrand(-2,1,N);
nVec = customrandn(1.5,2.0,N);

figure;
histogram(uVec,'normalization','pdf')
figure;
histogram(nVec,'normalization','pdf')