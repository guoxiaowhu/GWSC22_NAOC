%% 离散的滤波
%% 信号

%% 信号波形 
%f1 频率1
f1=100;
ph1=0;
%f2 频率2
f2=200;
ph2=pi/6;
%f3 频率3
f3=300;
ph3=pi/4;

Sig =@(timeVec)(sin(2*pi*f1*timeVec + ph1) + sin(2*pi*f2*timeVec + ph2)+ ...
    sin(2*pi*f3*timeVec + ph3));


%% 信号抽样参数
% Instantaneous frequency after 1 sec is 
maxFreq = max([f1, f2, f3]);
samplFreq = 1024;%5*maxFreq;%样本频率
samplIntrvl = 1/samplFreq;%样本时间间隔
nSamples= 2048;%samplFreq;%样本数量
%样本时间=样数量/样本频率=样本数量*样本时间间隔

% Time samples 时间序列
timeVec= (0:(nSamples-1))/samplFreq;%抽样时间序列
% signal samples 信号样本序列
sigVec=Sig(timeVec);

 
%% 滤波处理 lowpass
%Remove frequencies above half the maximum frequency
% Design low pass filter 低通滤波器设计
filtOrdr = 30;
% 横轴频率空间范围 samplFreq/2
% 归一化 1/(samplFreq/2)
b = fir1(filtOrdr,(f1+f2)/2/(samplFreq/2));
F0=figure;
freqz(b,1);
title('Lowpass Filtered Design')
saveas(F0,'LowpassDesign.jpg');
% Apply filter
filtSig = fftfilt(b,sigVec);

 %% Plots 绘制滤波前后对比图
F1=figure;
subplot(2,1,1);
plot(timeVec(1:100),sigVec(1:100));
title('Original Signal')
ylabel('Amplitude');
subplot(2,1,2); 
plot(timeVec(1:100),filtSig(1:100));
title('Lowpass Filtered Signal')
xlabel('Time (seconds)');
ylabel('Amplitude');
saveas(F1,'LowpassSig.jpg');

%% FFT of signal 信号的快速傅里叶变换前后对比图
 % 信号的傅里叶变换
 % 滤波前
 fftSig = fft(sigVec);
 % 滤波后
 fftfiltSig = fft(filtSig);
 
 % 频率空间序列
 posFreq=(1:(floor(nSamples/2)+1))*(samplFreq/nSamples);

%Plot periodogram
nposFreq=length(posFreq);
F2=figure;
subplot(2,1,1);
plot(posFreq,abs(fftSig(1:nposFreq)));
ylabel('Magnitude');
title('Original Signal')
subplot(2,1,2);
plot(posFreq,abs(fftfiltSig(1:nposFreq)));
title('Lowpass Filtered Signal')
xlabel('Frequency (Hz)');
ylabel('Magnitude');
saveas(F2,'LowpassfftSig.jpg');
