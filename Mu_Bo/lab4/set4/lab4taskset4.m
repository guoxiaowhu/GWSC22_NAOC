%% Read the data in
dataID1=fopen('C:/Users/BASE/Documents/MATLAB/SIGNALS/data1.txt');
C1=textscan(dataID1,'%f');
data1=C1{1};
data1=data1';


dataID2=fopen('C:/Users/BASE/Documents/MATLAB/SIGNALS/data2.txt');
C2=textscan(dataID2,'%f');
data2=C2{1};
data2=data2';

dataID3=fopen('C:/Users/BASE/Documents/MATLAB/SIGNALS/data3.txt');
C3=textscan(dataID3,'%f');
data3=C3{1};
data3=data3';


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
Lg1=glrtqcsig(data1,psdPosFreq,[10,3,3])
Lg2=glrtqcsig(data2,psdPosFreq,[10,3,3])
Lg3=glrtqcsig(data3,psdPosFreq,[10,3,3])
LgM=glrtqcsig(noiseVec,psdPosFreq,[10,3,3])


%% Show the data image
figure;
plot(timeVec,data1);
hold on;

figure;
plot(timeVec,data2);
hold on;

figure;
plot(timeVec,data3);
hold on;

figure;
plot(timeVec,noiseVec);
hold on;
