%% Plot the AM-FM signal 绘制AM-FM信号
% Signal parameters 
% \cos(2 \pi f2 t)*  \sin (2 \pi f0 t + b \cos(2 \pi f1 t))
% 其中,Note that f0>>f1>f2
% 初始化参数
f0=100;
f1=10;
f2=5;
b=1;
% the matched filtering signal-to-noise ratio of S
A = 1;

% Instantaneous frequency after 1 sec is 
maxFreq = f0;
samplFreq = 6*maxFreq;%样本频率
samplIntrvl = 1/samplFreq;%样本时间间隔
nSamples=600;%样本数量
%Length of data 信号时间长度 T
%样本时间长度T=样数量/样本频率=样本数量*样本时间间隔
dataLen =nSamples/samplFreq;
% Time samples 时间序列
timeVec= (0:(nSamples-1))/samplFreq;%抽样时间序列


%% Generate the signal 产生信号
sigVec = AMFMsig(timeVec,A,[b, f0, f1, f2]);

%Plot the signal 
figure;
F1=plot(timeVec,sigVec,'Marker','.','MarkerSize',2);
xlabel('Time (seconds)');
ylabel('Amplitude');
saveas(F1,'Sig.jpg');


%% Plot the periodogram 绘制信号周期图
%--------------
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

%Plot periodogram
figure;
F2=plot(posFreq,abs(fftSig));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
saveas(F2, 'FftAMFMSig.jpg');


%Plot a spectrogram
%----------------
winLen = 0.5;%sec
ovrlp = 0.1;%sec
%Convert to integer number of samples 
winLenSmpls = floor(winLen*samplFreq);
ovrlpSmpls = floor(ovrlp*samplFreq);
[S,F,T]=spectrogram(sigVec,winLenSmpls,ovrlpSmpls,[],samplFreq);
figure;
F3 = imagesc(T,F,abs(S)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
saveas(F3, 'TFAMFMSig.jpg');
