%% 傅里叶变换
% 获得信号数据
%% Signals and audio
% Time domain signal: sum of two sinusoids with frequencies 5 Hz and 1 Hz
nSamples = 600;%样本数量
samplingFreq = 600;%抽样频率
T=1/samplingFreq;%抽样时间间隔
timeVec= (0:(nSamples-1))/samplingFreq;%抽样时间序列

% %%
% %f1 频率1
% f1=100;
% %f2 频率2
% f2=200;
% Sig = sin(2*pi*f1*timeVec)+2*sin(2*pi*f2*timeVec);
% %Sig = sin(2*pi*f1*t);

%% %%%%%%%%%%%%%%%%%
%%the AM-FM signal AM-FM信号
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

% Generate the signal
Sig = AMFMsig(timeVec,A,[b, f0, f1, f2]);


%%
F1=plot(timeVec,Sig);
xlabel('Time (seconds)');
ylabel('Amplitude');
saveas(F1,'Sig.jpg');
% FFT of signal 信号的快速傅里叶变换
fftSig=fftshift(fft(Sig));
% 频率空间序列
% posFreq=(1-(floor(nSamples/2)):(floor(nSamples/2)))*(samplingFreq/nSamples);

posFreq=(1:(floor(nSamples/2)+1))*(samplingFreq/nSamples);

%Plot periodogram
figure;
F2=plot(posFreq,abs(fftSig(1:length(posFreq))));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
saveas(F2, 'FftSig.jpg');