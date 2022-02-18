N = 10000;
uVec = customrand(-2,1,N);
nVec = customrandn(1.5,2.0,N);

figure;
hold on;
plot([-2,1],[1/3,1/3],'r');
histogram(uVec,'normalization','pdf');
xlabel('x');
ylabel('PDF');
figure;
histogram(nVec,'normalization','pdf');