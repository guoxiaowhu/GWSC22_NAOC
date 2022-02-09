function sigVec = SiGasig(dataX,snr,AMFMCoefs)
% Generate a AM-FM sinusoid signal
% S = AMFMsig(X,SNR,C)
% Generates a AM-FM sinusoid signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. 
% SNR is the matched filtering signal-to-noise ratio of S and 
% C is the vector of Four coefficients [t0, sigma, f0, phi0] 
% that parametrize the signal:  
% exp(-(t-t0).^2/(2*sigma^2)).*sin(2*pi*f0*t + phi0)

%YunLong Liu, 08/02/2022


sigVec = exp(-(dataX-AMFMCoefs(1)).^2/(2*AMFMCoefs(2)^2)).*...
    sin(2*pi*AMFMCoefs(3)*dataX+AMFMCoefs(4));

sigVec = snr*sigVec/norm(sigVec);