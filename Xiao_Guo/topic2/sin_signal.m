%% filter
% addpath ../SIGNALS;
sampFreq = 2;
nSamples = 2048;

timeVec = (0:(nSamples-1))/sampFreq;

%% sinusoids signals
% Signal parameters
A_p = 10;
A_c = 7.5;

f_0 = 0.01;
phi_0 = pi/6;

% Signal length
sigLen = (nSamples-1)/sampFreq;
%Maximum frequency
maxFreq = f_0;

% Generate signal
sigVec_p = crcbgenSinsig(timeVec,A_p,f_0,0); 
sigVec_c = crcbgenSinsig(timeVec,A_c,f_0,phi_0); 

%Polar angle
theta = 0.6;
%Azimuthal angle
phi = 1.8;
%Polarization angle
psi = 1;

%Generate function values

% StrainSig = zeros(nSamples);
%for i = 1:nSamples
    %StrainSig(i) = Strain_F(sigVec_p(i),sigVec_c(i),theta,phi,psi);
%    StrainSig(i) = Strain_Tensor(sigVec_p(i),sigVec_c(i),theta,phi,psi);
%end
StrainSig = Strain_F(sigVec_p,sigVec_c,theta,phi,psi);
%StrainSig = Strain_Tensor(sigVec_p,sigVec_c,theta,phi,psi);
%% Plots
figure;
hold on;
plot(timeVec,sigVec_p,'r');
plot(timeVec,sigVec_c,'g');
xlabel('Time(s)')
ylabel('Amplitude')
plot(timeVec,StrainSig,'b');
legend('h_+','h_\times','s')
xlim([0,1024])
