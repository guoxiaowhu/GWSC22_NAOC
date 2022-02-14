%% Parameters for data realization
% Number of samples and sampling frequency.
nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;

%% Supply PSD values
% This is the noise psd we will use.
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);

%% Generate  M data realization 
noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);

%% Compute GLRT
LgM=glrtqcsig(noiseVec,psdPosFreq,[10,3,3])


%% Show the data image
figure;
plot(timeVec,noiseVec);
hold on;
