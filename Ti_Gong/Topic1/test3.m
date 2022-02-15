clear
close all
A=1;
Coefs=[20,0];
TimeVec=0:0.001:1;
Signal=gensigvec(TimeVec,A,Coefs,1);
samplFreq=1000;
%Plot a spectrogram
%----------------
winLen = 0.2;%sec
ovrlp = 0.1;%sec
%Convert to integer number of samples 
winLenSmpls = floor(winLen*samplFreq);
ovrlpSmpls = floor(ovrlp*samplFreq);
[S,F,T]=spectrogram(Signal,winLenSmpls,ovrlpSmpls,[],samplFreq);
figure;
imagesc(T,F,abs(S)); axis xy;
xlabel('Time/s');
ylabel('Frequency/Hz');