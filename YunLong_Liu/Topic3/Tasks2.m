%% 导入数据
testData=load('testData.txt');
% colored Gaussian noise
% 假设我们确定无数据的白噪声部分为0-5s
%数据长度
Cn=floor(length(testData(:,1))*(5/testData(end,1)));
%样本频率
sampFreq=1/(testData(2,1)-testData(1,1));
%有色时间序列
Ctime=testData(1:Cn,1);
%有色噪音序列
Cnoise=testData(1:Cn,2);
F0=plot(Ctime,Cnoise);
saveas(F0, 'Cnoise.jpg');
%总时间序列
time=testData(:,1);
%总信号序列
innoise=testData(:,2);

%%
% Estimate the PSD
% (Pwelch plots in dB (= 10*log10(x)); plot on a linear scale)
[pxx,f]=pwelch(Cnoise, 128,[],[],sampFreq);


% Plot the colored noise realization
% 需不需要对功率谱密度进行光滑化处理?
% PSD(Power Spectral Density) 功率谱密度
%Target PSD given by the inline function handle
PSDfun=polyfit(f, pxx, 20);
%targetPSD = @(f) (f>=0 & f<=3000).*1;
%Plot PSD % 绘制目标功率谱密度图
freqVec = 0:0.1:sampFreq/2;
psdVec = polyval(PSDfun, freqVec);
F1=figure;
plot(freqVec,psdVec);
hold on 
plot(f,pxx,'*');
xlabel('Frequency (Hz)');
ylabel('PSD');
saveas(F1, 'CnoisePSD.jpg');




%% Generate noise realization
%% 白噪声产生的实现
fltrOrdr = 300;
outnoise =Whitencolgaussnoisegen([freqVec',psdVec'],fltrOrdr,...
    sampFreq,innoise);
% outnoise =Whitencolgaussnoisegen([f,pxx],fltrOrdr,...
%     sampFreq,innoise);





% %%
% % Estimate the PSD
% % (Pwelch plots in dB (= 10*log10(x)); plot on a linear scale)
% [pxx,f]=pwelch(outnoise, 256,[],[],sampFreq);
% figure;
% plot(f,pxx);
% xlabel('Frequency (Hz)');
% ylabel('PSD');
% % Plot the colored noise realization
% figure;
% plot(testData(:,1),outnoise);

%Plot a spectrogram
%----------------
winLen = 0.1;
ovrlp = 0.05;
%Convert to integer number of samples 
winLenSmpls = floor(winLen*sampFreq);
ovrlpSmpls = floor(ovrlp*sampFreq);


[S,F,T]=spectrogram(innoise,winLenSmpls,ovrlpSmpls,[],sampFreq);
[WS,WF,WT]=spectrogram(outnoise,winLenSmpls,ovrlpSmpls,[],sampFreq);
figure;
F8=imagesc(T,F,abs(S)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
colorbar;
saveas(F8, 'TFinSig.jpg');
figure;
F9=imagesc(WT,WF,abs(WS)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
colorbar;
saveas(F9, 'TFoutSig.jpg');
figure;
F10=plot(time,innoise,'r');
saveas(F10, 'inSig.jpg');
figure;
F11=plot(time,outnoise,'b');
xlabel('time')
saveas(F11, 'outSig.jpg');


