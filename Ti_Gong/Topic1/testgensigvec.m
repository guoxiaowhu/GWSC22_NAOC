clear;
close all;

A = 1;
Coefs = {[20,0],[1,20,0],[0.5,0.1,100,0],[10,20,1],[20,1,0],[10,20,1],[-1,1,5,0,2],[-1,10,1,0,2],[0,1,10]};
TimeVec = {0:0.001:1,0:0.001:1,0:0.001:1,0:0.001:4,0:0.001:4,0:0.001:4,-2:0.001:2,-2:0.001:2,-2:0.001:2};
SigTilte={'Sinusoidal signal','Linear chirp signal','Sine-Gaussian signal','FM sinusoid','AM sinusoid','AM-FM sinusoid','Linear transient chirp','Exponentially damped sinusoid','Step FM'};

% Generate signals
figure;
for i=1:9
    Signal = gensigvec(TimeVec{i},A,Coefs{i},i);
    subplot(3,3,i);
    plot(TimeVec{i},Signal);
    title(SigTilte{i});
    xlabel('Time/s')
    ylabel('Signal')
end

% Plot periodogram
figure;
for i=1:9
    dataLen = TimeVec{i}(end) - TimeVec{i}(1);
    nSamples = length(TimeVec{i});
    kNyq = 160;
    %kNyq = floor(nSamples/2) + 1;
    posFreq = (0:(kNyq-1))*(1/dataLen);
    Signal = gensigvec(TimeVec{i},A,Coefs{i},i);
    fftSig = fft(Signal);
    fftSig = fftSig(1:kNyq);
    subplot(3,3,i);
    plot(posFreq,abs(fftSig));
    title(SigTilte{i});
    xlabel('Frequency/Hz')
    ylabel('Periodogram')
end

% Plot spectrogram
winLen = 0.2;
ovrlp = 0.1;
samplFreq=500;
winLenSmpls = floor(winLen*samplFreq);
ovrlpSmpls = floor(ovrlp*samplFreq);
figure;
for i=1:9
    Signal = gensigvec(TimeVec{i},A,Coefs{i},i);
    [S,F,T]=spectrogram(Signal,winLenSmpls,ovrlpSmpls,[],samplFreq);
    subplot(3,3,i);
    imagesc(T,F,abs(S));
    title(SigTilte{i});
    axis xy;
    xlabel('Time/s');
    ylabel('Frequency/Hz');
end