y = load('iLIGOSensitivity.txt','-ascii');
%figure;
%loglog(y(:,1),y(:,2));
freq =y(:,1);
PSD = (y(:,1)>50&y(:,1)<700).*y(:,2)+(y(:,1)<50).*y(sum((y(:,1)<50)),2)...
    +(y(:,1)>700).*y(length(y(:,1))-sum((y(:,1)>700)),2);
figure;
loglog(freq,PSD);

%Sampling frequency for noise realization
sampFreq = 4096; %Hz
%Number of samples to generate
nSamples = 16384*4;


linfreq = 0:sampFreq/2/(nSamples-1):sampFreq/2;
linPSD = interp1(freq,PSD,linfreq,'linear','extrap');
loglog(linfreq,linPSD);
xlabel('Frequency (Hz)');
ylabel('Strain Sensitivity (1/\sqrt{Hz})');


%Time samples
timeVec = (0:(nSamples-1))/sampFreq;
fltrOrdr = 1000;

outNoise = statgaussnoisegen(nSamples,[linfreq(:),linPSD(:)],fltrOrdr,sampFreq);

[pxx1,f]=pwelch(outNoise, 2048,[],[],sampFreq);%one side PSD
pxx=pxx1/2;%two side PSD
figure;
hold on;
plot(f,pxx,'b');
plot(freq,PSD,'r');
xlim([0,sampFreq/2]);
xlabel('Frequency (Hz)');
ylabel('PSD');

whiteNoise= WhitenNoise(outNoise,[f,pxx],fltrOrdr,sampFreq);


winLen = 0.1;
ovrlp = 0.05;
%Convert to integer number of samples 
winLenSmpls = floor(winLen*sampFreq);
ovrlpSmpls = floor(ovrlp*sampFreq);
[S,F,T]=spectrogram(outNoise,winLenSmpls,ovrlpSmpls,[],sampFreq);
[WS,WF,WT]=spectrogram(whiteNoise,winLenSmpls,ovrlpSmpls,[],sampFreq);
figure;
imagesc(T,F,abs(S)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
colorbar;
figure;
imagesc(WT,WF,abs(WS)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
colorbar;
figure;
hold on;
plot(timeVec,outNoise,'r');
figure;
plot(timeVec,whiteNoise,'b');
xlabel('time')