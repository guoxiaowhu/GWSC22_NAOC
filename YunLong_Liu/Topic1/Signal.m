%% Topic I Part A: 二次啁啾信号(Plot the quadratic chirp signal)
%信号

%% 信号初始参数
% Signal parameters
a1=10;
a2=3;
a3=3;
A = 10;
% Instantaneous frequency after 1 sec is 
maxFreq = a1+2*a2+3*a3;
samplFreq = 2*maxFreq;
samplIntrvl = 1/samplFreq;

% Time samples 数据的时间长度
timeVec = 0:samplIntrvl:1.0;
% Number of samples
nSamples = length(timeVec);

% Generate the signal 产生信号
% sigVec = A \frac{\sin(2 \pi (a_1 t + a_2 t^2 + a_3 t^3))}{\left| \sin(2 \pi (a_1 t + a_2 t^2 + a_3 t^3))\right|} ;
sigVec = crcbgenqcsig(timeVec,A,[a1,a2,a3]);

%Plot the signal  绘制信号图
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',20);
xlabel('time')



%% Plot the periodogram 绘制周期图
%--------------
%Length of data 信号长度
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency 
%二次啁啾信号样本对应的奈奎斯特(Nyquist)频率
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal 信号的快速傅里叶变换
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

%Plot periodogram
figure;
plot(posFreq,abs(fftSig));

%Plot a spectrogram
%----------------
winLen = 0.2;%sec
ovrlp = 0.1;%sec
%Convert to integer number of samples 
winLenSmpls = floor(winLen*samplFreq);
ovrlpSmpls = floor(ovrlp*samplFreq);
[S,F,T]=spectrogram(sigVec,winLenSmpls,ovrlpSmpls,[],samplFreq);
figure;
imagesc(T,F,abs(S)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
