%% colored Gaussian noise generation of iLIGO
%% 有色高斯噪音iLIGO

%Sampling frequency for noise realization
%噪声采样频率实现
sampFreq = 4096; %Hz
%Number of samples to generate
nSamples = 16384*4;
%Time samples
%时间序列
timeVec = (0:(nSamples-1))/sampFreq;

% PSD(Power Spectral Density) 功率谱密度
%Target PSD given by the inline function handle
y = load('iLIGOSensitivity.txt','-ascii');
%figure;
%loglog(y(:,1),y(:,2));
freq =y(:,1);
PSD = (y(:,1)>50&y(:,1)<700).*y(:,2)+(y(:,1)<50).*y(sum((y(:,1)<50)),2)...
    +(y(:,1)>700).*y(length(y(:,1))-sum((y(:,1)>700)),2);
% figure;
% F1=loglog(freq,PSD);
% saveas(F1, 'Target_PSD.jpg');



%targetPSD = @(f) (f>=0 & f<=3000).*1;
%Plot PSD % 绘制目标功率谱密度区间
freqVec = 0:sampFreq/2/(nSamples-1):sampFreq/2;
psdVec = interp1(freq,PSD,freqVec,'pchip');

%% Generate noise realization
%% 噪声产生的实现
fltrOrdr = 1000;
Noise = statgaussnoisegen(nSamples,[freqVec(:),psdVec(:)],fltrOrdr,sampFreq);


%%
% Estimate the PSD
% (Pwelch plots in dB (= 10*log10(x)); plot on a linear scale)
[pxx,f]=pwelch(Noise, 1024 ,[],[],sampFreq);

%% 绘图并保存
F2=figure;
plot(f,pxx/2,'b');hold on 
plot(freqVec,psdVec,'r','LineWidth',1);
xlim([0,sampFreq/2]);
xlabel('Frequency (Hz)');
ylabel('PSD');
legend('PSD of out noise','Target PSD')
saveas(F2, 'iLIGO_Target_PSD.jpg');
% Plot the colored noise realization
F3=figure;
plot(timeVec,Noise);
saveas(F3, 'iLIGO_Output_noise.jpg');

%% Generate noise realization
%% 白噪声产生的实现
fltrOrdr = 500;
outNoise =Whitencolgaussnoisegen([freqVec',psdVec'],fltrOrdr,...
    sampFreq,Noise);
% outnoise =Whitencolgaussnoisegen([f,pxx],fltrOrdr,...
%     sampFreq,innoise);





%Plot a spectrogram
%----------------
winLen = 0.1;
ovrlp = 0.05;
%Convert to integer number of samples 
winLenSmpls = floor(winLen*sampFreq);
ovrlpSmpls = floor(ovrlp*sampFreq);


[S,F,T]=spectrogram(Noise,winLenSmpls,ovrlpSmpls,[],sampFreq);
[WS,WF,WT]=spectrogram(outNoise,winLenSmpls,ovrlpSmpls,[],sampFreq);
figure;
F8=imagesc(T,F,abs(S)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
colorbar;
saveas(F8, 'iLIGO_TFinSig.jpg');
figure;
F9=imagesc(WT,WF,abs(WS)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
colorbar;
saveas(F9, 'iLIGO_TFoutSig.jpg');

figure;
F10=plot(timeVec ,Noise,'r');
saveas(F10, 'iLIGO_inSig.jpg');
figure;
F11=plot(timeVec ,outNoise,'b');
xlabel('time')
saveas(F11, 'iLIGO_outSig.jpg');









