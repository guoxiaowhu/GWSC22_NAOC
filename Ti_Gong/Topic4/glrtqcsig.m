function llr = glrtqcsig(dataVec,psdPosFreq,Coefs,sampFreq)
% Calculate GLRT for Quadratic chirp signal
% LLR = GLRTQCSIG(DATAVEC,PSDPOSFREQ,COEFS,SAMPFREQ)
% Generalized Likelihood ratio test (GLRT) for a
% quadratic chirp when only the amplitude is unknown.
% The value used for 'A' does not matter because
% we are going to normalize the signal anyway.

% Ti Gong, Feburary 2022

% Number of samples.
nSamples = length(dataVec);
timeVec = (0:(nSamples-1))/sampFreq;

% Generate quadratic chirp signal
sigVec = crcbgenqcsig(timeVec,1,[Coefs(1),Coefs(2),Coefs(3)]);
% We do not need the normalization factor, just the template vector
[templateVec,~] = normsig4psd(sigVec,sampFreq,psdPosFreq,1);
% Calculate inner product of data with template
llr = innerprodpsd(dataVec,templateVec,sampFreq,psdPosFreq);
% GLRT is its square
llr = llr^2;

end