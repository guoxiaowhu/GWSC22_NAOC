clear;
close all;

addpath(genpath('../'));

dataVec1 = load('../DETEST/data1.txt').';
dataVec2 = load('../DETEST/data2.txt').';
dataVec3 = load('../DETEST/data3.txt').';

a1 = 10;
a2 = 3;
a3 = 3;
Coefs = [a1,a2,a3];

nSamples = 2048;
sampFreq = 1024;
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);

glrt1 = glrtqcsig(dataVec1,psdPosFreq,Coefs,sampFreq);
glrt2 = glrtqcsig(dataVec2,psdPosFreq,Coefs,sampFreq);
glrt3 = glrtqcsig(dataVec3,psdPosFreq,Coefs,sampFreq);

nH0data = 10000;
llrH0 = zeros(1,nH0data);
for i = 1:nH0data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    llrH0(i) = glrtqcsig(noiseVec,psdPosFreq,Coefs,sampFreq);
end

significance1 = sum(llrH0 > glrt1)/nH0data;
significance2 = sum(llrH0 > glrt2)/nH0data;
significance3 = sum(llrH0 > glrt3)/nH0data;

disp(['Significance of GLRT data1 is ', num2str(significance1)]);
disp(['Significance of GLRT data2 is ', num2str(significance2)]);
disp(['Significance of GLRT data3 is ', num2str(significance3)]);
