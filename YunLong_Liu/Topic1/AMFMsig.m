function sigVec = AMFMsig(dataX,snr,AMFMCoefs)
% Generate a AM-FM sinusoid signal
% S = AMFMsig(X,SNR,C)
% Generates a AM-FM sinusoid signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. 
% SNR is the matched filtering signal-to-noise ratio of S and 
% C is the vector of Four coefficients [b, f0, f1, f2] 
% that parametrize the signal:  
% \cos(2 \pi f2 t)*  \sin (2 \pi f0 t + b \cos(2 \pi f1 t))
% Note that f0>>f1>f2

%YunLong Liu, 08/02/2022


sigVec = cos(2*pi*AMFMCoefs(4)*dataX ).*sin(2*pi*AMFMCoefs(2)*dataX  ...
        + AMFMCoefs(1)*cos(2*pi*AMFMCoefs(3)*dataX ));
sigVec = snr*sigVec/norm(sigVec);