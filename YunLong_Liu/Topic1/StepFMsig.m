function sigVec = StepFMsig(dataX,snr,AMFMCoefs)
% Generate a AM-FM sinusoid signal
% S = AMFMsig(X,SNR,C)
% Generates a AM-FM sinusoid signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. 
% SNR is the matched filtering signal-to-noise ratio of S and 
% C is the vector of Four coefficients [ta, f0, f1] 
% that parametrize the signal:  
% if t<=ta : SNR \sin(2 \pi f0 t)
% if t> ta : SNR \sin(2 \pi f1 (t-ta) + 2 \pi f0 ta)

%YunLong Liu, 08/02/2022


sigVec = sin(2*pi*AMFMCoefs(2)*dataX).*(dataX<=AMFMCoefs(1))...
    + sin(2*pi*AMFMCoefs(3)*dataX + 2*pi*AMFMCoefs(2)*AMFMCoefs(1))...
    .*(dataX>AMFMCoefs(1));


sigVec = snr*sigVec/norm(sigVec);