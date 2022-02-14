function llr = glrtqcsig(dataVec,psdPosFreq,C1)

%% Compute GLRT
%Generate the unit norm signal (i.e., template). Here, the value used for
%'A' does not matter because we are going to normalize the signal anyway,
%so we set it as 1.
%Note: the GLRT here is for the unknown amplitude case, that is all other
%signal parameters are known
nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;
sigVec = crcbgenqcsig(timeVec,1,[C1(1),C1(2),C1(3)]);
sigVec = sigVec/norm(sigVec);
%We do not need the normalization factor, just the  template vector
[templateVec,~] = normsig4psd(sigVec,sampFreq,psdPosFreq,1);
% Calculate inner product of data with template
llr = innerprodpsd(dataVec,templateVec,sampFreq,psdPosFreq);
%GLRT is its square
llr = llr^2;
