%% How to normalize a signal for a given SNR
% We will normalize a signal such that the Likelihood ratio (LR) test for it has
% a given signal-to-noise ratio (SNR) in noise with a given Power Spectral 
% Density (PSD). [We often shorten this statement to say: "Normalize the
% signal to have a given SNR." ]

%%
clear;
close all;

%%
% Path to folder containing signal and noise generation codes
addpath(genpath('../'));

%%
% This is the target SNR for the LR
snr = 10;

%%
% Data generation parameters
nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;


%%
% Generate the signal that is to be normalized
a1=1;
a2=20;
a3=0;
% Amplitude value does not matter as it will be changed in the normalization
A = 1;
signaltype = 2;
sigVec = gensigvec(timeVec,A,[a1,a2,a3],signaltype);

%%
% We will use the noise PSD used in colGaussNoiseDemo.m but add a constant
% to remove the parts that are zero. (Exercise: Prove that if the noise PSD
% is zero at some frequencies but the signal added to the noise is not,
% then one can create a detection statistic with infinite SNR.)
ligoPsd = load('../NOISE/iLIGOSensitivity.txt','-ascii');
f_sampl = 10000;

iLIGO_mod = zeros(size(ligoPsd));
iLIGO_trunc = [];
for i = 1:length(ligoPsd(:,1))
    iLIGO_mod(i,1) = ligoPsd(i,1);
    if (ligoPsd(i,1) < 50 & ligoPsd(i+1,1) > 50)
        iLIGO_mod(1:i,2) = ligoPsd(i,2)*ones(i,1);
    
    elseif (ligoPsd(i,1) < 700 & ligoPsd(i+1,1) > 700)
        iLIGO_mod(i,2) = ligoPsd(i,2);
        iLIGO_mod(i+1:end,1) = ligoPsd(i+1:end,1);
        iLIGO_mod(i+1:end,2) = ligoPsd(i,2)*ones(length(ligoPsd(:,1)) - i,1);
        break
    else
        iLIGO_mod(i,2) = ligoPsd(i,2);
    end
end
for i = 1:length(iLIGO_mod(:,1))
    if (ligoPsd(i,1) < f_sampl/2 & ligoPsd(i+1,1) > f_sampl/2)
        tmp1 = ligoPsd(i+1:end,:);
        iLIGO_mod(i+1,:) = [f_sampl/2, (ligoPsd(i,2) + ligoPsd(i+1,2))/2];
        iLIGO_trunc = iLIGO_mod(1:i+1,:);
        iLIGO_mod = [iLIGO_mod(1:i+1,:);tmp1];
        break
    end
end
tmp = [[0,iLIGO_mod(1,2)];iLIGO_mod];
iLIGO_mod = tmp;

%%
% Generate the PSD vector to be used in the normalization. Should be
% generated for all positive DFT frequencies. 
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = interp1(iLIGO_mod(:,1),iLIGO_mod(:,2),posFreq);
figure;
plot(posFreq,psdPosFreq);
axis([0,posFreq(end),0,max(psdPosFreq)]);
xlabel('Frequency/Hz');
ylabel('PSD ((data unit)^2/Hz)');

%% Calculation of the norm
% Norm of signal squared is inner product of signal with itself
normSigSqrd = innerprodpsd(sigVec,sigVec,sampFreq,psdPosFreq);
% Normalize signal to specified SNR
sigVec = snr*sigVec/sqrt(normSigSqrd);

%% Test
%Obtain LLR values for multiple noise realizations
nH0Data = 1000;
llrH0 = zeros(1,nH0Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    llrH0(lp) = innerprodpsd(noiseVec,sigVec,sampFreq,psdPosFreq);
end
%Obtain LLR for multiple data (=signal+noise) realizations
nH1Data = 1000;
llrH1 = zeros(1,nH1Data);
for lp = 1:nH1Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    % Add normalized signal
    dataVec = noiseVec + sigVec;
    llrH1(lp) = innerprodpsd(dataVec,sigVec,sampFreq,psdPosFreq);
end
%%
% Signal to noise ratio estimate
estSNR = (mean(llrH1)-mean(llrH0))/std(llrH0);

figure;
histogram(llrH0);
hold on;
histogram(llrH1);
xlabel('LLR');
ylabel('Counts');
legend('H_0','H_1');
title(['Estimated SNR = ',num2str(estSNR)]);

%%
% A noise realization
figure;
plot(timeVec,noiseVec);
xlabel('Time/s');
ylabel('Noise');
%%
% A data realization
figure;
plot(timeVec,dataVec);
hold on;
plot(timeVec,sigVec);
xlabel('Time/s');
ylabel('Data');

%%
% Plot the periodogram
% FFT of signal and data
fftSig = fft(sigVec);
fftData = fft(dataVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);
fftData = fftData(1:kNyq);
% Plot
figure;
plot(posFreq,abs(fftData));
hold on;
plot(posFreq,abs(fftSig));
xlabel('Frequency/Hz');
ylabel('Periodogram');

%%
% Plot the spectrogram
[S,F,T]=spectrogram(dataVec,64,60,[],sampFreq);
figure;
imagesc(T,F,abs(S));
axis xy;
xlabel('Time/s');
ylabel('Frequency/Hz');
