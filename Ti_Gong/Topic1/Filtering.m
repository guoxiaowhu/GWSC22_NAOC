nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;

s1 = 10*sin(2*pi*100*timeVec);
s2 = 5*sin(2*pi*200*timeVec + pi/6);
s3 = 2.5*sin(2*pi*300*timeVec + pi/4);
s = s1 + s2 + s3;

filt0rdr = 30;
maxFreq = 300;
b = fir1(filt0rdr,(maxFreq/2)/(sampFreq/2));
filtSig = fftfilt(b,s);
figure;
plot(timeVec,s);
figure;
plot(timeVec,filtSig);