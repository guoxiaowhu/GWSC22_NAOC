clear
close all

% Generate signals
A = 1;
Coefs = {[20,0],[1,20,0],[0.5,0.1,100,0],[10,20,1],[20,1,0],[10,20,1],[-1,1,5,0,2],[-1,10,1,0,2],[0,1,10]};
TimeVec = {0:0.001:1,0:0.001:1,0:0.001:1,0:0.001:4,0:0.001:4,0:0.001:4,-2:0.001:2,-2:0.001:2,-2:0.001:2};
SigTilte={'Sinusoidal signal','Linear chirp signal','Sine-Gaussian signal','FM sinusoid','AM sinusoid','AM-FM sinusoid','Linear transient chirp','Exponentially damped sinusoid','Step FM'};
for i=1:9
    Signal = gensig(TimeVec{i},A,Coefs{i},i);
    subplot(3,3,i);
    plot(TimeVec{i},Signal);
    title(SigTilte{i});
end