clear
close all
A=1;
a=[0.2,101,103,4,1];
n=2048;
step=1e-3;
timeline=linspace(0,step*n,n);
modeType=1:1:8;
sigTilte={'the sinusoidal signal','the linear chirp signal','the sine-gaussian signal','the FM sinusoid','the AM sinusoid','the AM-FM sinusoid','the time-shift signal','the quadratic chirp signal'};
hold on

for i=1:length(modeType)
    
    signal=gensi9(timeline,A,a,i);
    subplot(2,4,i)
%    plot(gca,timeline,signal,'-')
    title(sigTilte(i));
end
% Generate signals

for i=1:length(modeType)
    
    signal=gensi9(timeline,A,a,i);
    fre=getfre(timeline,signal);
    fremax=max(fre);
    
    sigfft=fft(signal,n);
    freLen=floor(length(timeline)/2+1);
    time_interval=timeline(end)-timeline(1);
    fs=1/time_interval;
    freline = fs*(0:(n/2))/n;
    sigfft=abs(sigfft);
    subplot(2,4,i)
    plot(gca,freline,sigfft(1:length(freline)),'-')
    title(sigTilte(i));
    ylabel('intension');
    xlabel('Frequency(Hz)')
end
% fft part
for i=1:length(modeType)
    
    signal=gensi9(timeline,A,a,i);
    fre=getfre(timeline,signal);
    fremax=max(fre);
    
    sigfft=fft(signal,n);
    freLen=floor(length(timeline)/2+1);
    time_interval=timeline(end)-timeline(1);
    fs=time_interval/step;
    freline = fs*(0:(n/2))/n;
    sigfft=abs(sigfft);
    
    filt0rdr=30;
    b=fir1(filt0rdr,fremax/fs/2);
    filtsig=fftfilt(b,signal);
    
    winLen=0.01;
    overlap=winLen/3;
    winlensample=floor(winLen*fs);overlapsample=floor(overlap*fs);
    [S,F,T]=spectrogram(signal,winlensample,overlapsample,[],fs);
    subplot(2,4,i)
    imagesc(gca,T,F,abs(S));axis xy
    title(sigTilte(i));
    xlabel('Time(sec)');
    ylabel('Frequency(Hz)')
end
% filter & spectrogram part


set(gcf,'color',[1,1,1],'units','normalized','position',[0.2,0.2,0.5,0.5]);