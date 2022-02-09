%% Low pass filter demo
addpath ../SIGNALS;
sampFreq = 1024;
nSamples = 2048;

timeVec = (0:(nSamples-1))/sampFreq;

%% 3 sinusoids signals
% Signal parameters
A1 = 10;
A2 = 5;
A3 = 2.5;

f1 = 100;
f2 = 200;
f3 = 300;
% f1<f2<f3
phi1 = 0;
phi2 = pi/6;
phi3 = pi/4;

% Signal length
sigLen = (nSamples-1)/sampFreq;
%Maximum frequency
maxFreq = max([f1,f2,f3]);
df = 50;
%disp(['The maximum frequency of the signal is ', num2str(maxFreq)]);

% Generate signal
sigVec1 = crcbgenSinsig(timeVec,A1,f1,phi1); %s_1
sigVec2 = crcbgenSinsig(timeVec,A2,f2,phi2); %s_2
sigVec3 = crcbgenSinsig(timeVec,A3,f3,phi3); %s_3
sigVec = sigVec1 + sigVec2 + sigVec3;
%% Only allow signal s_1 to pass
% Design low pass filter
filtOrdr = 30;
b = fir1(filtOrdr,(f2-df)/(sampFreq/2));
% Apply filter
filtSig1 = fftfilt(b,sigVec);

%% Plots
figure;
hold on;
plot(timeVec,sigVec);
plot(timeVec,filtSig1);

%Plot the periodogram
%--------------
%Length of data 
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

% FFT of filtered signal
fftFilSig1 = fft(filtSig1);
% Discard negative frequencies
fftFilSig1 = fftFilSig1(1:kNyq);
%Plot periodogram
figure;
hold on;
plot(posFreq,abs(fftSig),'b');
plot(posFreq,abs(fftFilSig1),'r');
xlabel('Frequency (Hz)');
%% Only allow signal s_2 to pass
% Design low pass filter
filtOrdr = 30;
b = fir1(filtOrdr,[(f1+df)/(sampFreq/2) (f3-df)/(sampFreq/2)],'bandpass');
% Apply filter
filtSig2 = fftfilt(b,sigVec);

%% Plots
figure;
hold on;
plot(timeVec,sigVec);
plot(timeVec,filtSig2);

% FFT of filtered signal
fftFilSig2 = fft(filtSig2);
% Discard negative frequencies
fftFilSig2 = fftFilSig2(1:kNyq);
%Plot periodogram
figure;
hold on;
plot(posFreq,abs(fftSig),'b');
plot(posFreq,abs(fftFilSig2),'r');
xlabel('Frequency (Hz)');
%% Only allow signal s_3 to pass
% Design low pass filter
filtOrdr = 30;
b = fir1(filtOrdr,(f2+df)/(sampFreq/2),'high');
% Apply filter
filtSig3 = fftfilt(b,sigVec);

%% Plots
figure;
hold on;
plot(timeVec,sigVec);
plot(timeVec,filtSig3);

% FFT of filtered signal
fftFilSig3 = fft(filtSig3);
% Discard negative frequencies
fftFilSig3 = fftFilSig3(1:kNyq);
%Plot periodogram
figure;
hold on;
plot(posFreq,abs(fftSig),'b');
plot(posFreq,abs(fftFilSig3),'r');
xlabel('Frequency (Hz)');

figure;
set(gcf,'position',[0,0,900,300]);
subplot(1,3,1);
hold on;
plot(posFreq,abs(fftSig),'b');
plot(posFreq,abs(fftFilSig1),'r');
xlabel('Frequency (Hz)');
title('Low pass filter');
subplot(1,3,2);
hold on;
plot(posFreq,abs(fftSig),'b');
plot(posFreq,abs(fftFilSig2),'r');
xlabel('Frequency (Hz)');
title('Band pass filter')
subplot(1,3,3);
hold on;
plot(posFreq,abs(fftSig),'b');
plot(posFreq,abs(fftFilSig3),'r');
xlabel('Frequency (Hz)');
title('High pass filter')