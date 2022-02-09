function sigVec = l1c2(dataX,snr,Coef)
% Generate a FM signal
% S = l1c1(X,SNR,C)
% Generates a sinusoidal signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of S and C is the
% three coefficients [f0, f1, b] that parametrize the phase of the signal:
% 2*pi*f0*t+b*cos(2*pi*f1*t). 

sigVec = sin(2*pi*Coef(1).*dataX + Coef(3).*cos(2*pi*Coef(2).*dataX));
sigVec = snr*sigVec/norm(sigVec);