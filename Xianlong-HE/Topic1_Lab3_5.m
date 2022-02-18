clear;clc;

% Signal parameters
A = 10; b = 10;
f0 = 200; f1 = 10;
ta = 0.5; t_end = 1;

% Instantaneous frequency after 1 sec is 
maxFreq = f1 + f0 + b*f1;
samplFreq = 5*maxFreq;
%samplFreq = 1/2*maxFreq;
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:t_end;
% Number of samples
nSamples = length(timeVec);

% AM-FM Signal
snrVec = A.*cos(2*pi*f1*timeVec);
%snrVec = A;    % FM
phaseVec = b.*cos(2*pi*f1*timeVec);
%phaseVec = b;  % AM
sigAMFM = snrVec.*sin(2*pi*f0.*timeVec+phaseVec);
% By using Trigonometric formula, AM-FM are the sum of two sinusoid:
% cos1*sin1 = 1/2*(sin(1+2)-sin(1-2))
% so the instantaneous frequencs:
% f_ins = f1 +- (f0 - b*sin(2*pi*f1*t)*f1)
sigSin = A.*sin(2*pi*f0.*timeVec);
sigFM = A.*sin(2*pi*f0.*timeVec+phaseVec);
sigAM = A.*cos(2*pi*f1*timeVec).*sin(2*pi*f0.*timeVec);

%figure;
%plot(timeVec,sigAMFM,'Marker','.','MarkerSize',24);
subplot(2,2,1)
plot(timeVec,sigSin,timeVec,sigAM);
title('Sine(blue) & A.M.(yellow)')
subplot(2,2,2)
plot(timeVec,sigSin,timeVec,sigFM);
title('Sine(blue) & F.M.(yellow)')
subplot(2,2,3)
plot(timeVec,sigAMFM,timeVec,sigAM);
title('AM-FM(blue) & AM(yellow)')
subplot(2,2,4)
plot(timeVec,sigAMFM,timeVec,sigFM);
title('AM-FM(blue) & -FM(yellow)')
print('Topic1-Lab3','-djpeg')

%------------------
% FFT of signal
fftSig = fft(sigAMFM);

%Length of data 
%dataLen = timeVec(end)-timeVec(1);
dataLen = t_end;
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% Discard negative frequencies
fftSigPosi = fftSig(1:kNyq);
%Plot periodogram
figure;
plot(posFreq,abs(fftSigPosi));
print('Topic1-Lab5-AM FM','-djpeg')
%plot((0:nSamples-1)*(1/dataLen),abs(fftSig));

figure;
spectrogram(sigAMFM, 256,250,[],samplFreq);
print('Topic1-Lab6-Spec of AM-FM','-djpeg')

