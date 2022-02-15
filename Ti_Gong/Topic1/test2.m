clear
close all
A=1;
Coefs=[0,1,10];
TimeVec=-2:0.001:2;
Signal=gensigvec(TimeVec,A,Coefs,9);
plot(TimeVec,Signal);
dataLen = TimeVec(end)-TimeVec(1);
nSamples = length(TimeVec);
kNyq = 100;
posFreq = (0:(kNyq-1))*(1/dataLen);
fftSig = fft(Signal);
fftSig = fftSig(1:kNyq);
figure;
plot(posFreq,abs(fftSig));