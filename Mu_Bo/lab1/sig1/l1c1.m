function sigVec = l1c1(dataX,snr,Coef)
% Generate a sinusoidal signal
% S = l1c1(X,SNR,C1,C2)
% Generates a sinusoidal signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of S and C1,C2 is the
% two coefficients [f0, phi0] that parametrize the phase of the signal:
% 2*pi*f0*t+phi0. 

sigVec = sin(2*pi*Coef(1).*dataX + Coef(2));
sigVec = snr*sigVec/norm(sigVec);