%% F_+ and F_x calculation
%Polar angle
theta = 0:0.01:pi;
%Azimuthal angle
phi = 0:.01:(2*pi);
%polarization angle
psi = 0;

[A,D] = meshgrid(phi,theta);
X = sin(D).*cos(A);
Y = sin(D).*sin(A);
Z = cos(D);

%Generate function values
fPlus = zeros(length(theta),length(phi));
fCross = zeros(length(theta),length(phi));
for lp1 = 1:length(phi)
    for lp2 = 1:length(theta)
        [fPlus(lp2,lp1),fCross(lp2,lp1)] = detframefpfc_psi(theta(lp2),phi(lp1),psi);
    end
end

%Plot
figure;
subplot(1,2,1);
surf(X,Y,Z,abs(fPlus));
shading interp;
axis equal;
%colorbar;
%figure;
subplot(1,2,2);
surf(X,Y,Z,abs(fCross));
shading interp;
axis equal;
%colorbar;

% Analytical form
%Generate function values
fPlus = zeros(length(theta),length(phi));
fCross = zeros(length(theta),length(phi));
for lp1 = 1:length(phi)
    for lp2 = 1:length(theta)
        [fPlus(lp2,lp1),fCross(lp2,lp1)] = fpfc_anal(theta(lp2),phi(lp1),psi);
    end
end

%Plot
figure;
subplot(1,2,1);
surf(X,Y,Z,abs(fPlus));
shading interp;
axis equal;
%colorbar;
subplot(1,2,2);
surf(X,Y,Z,abs(fCross));
shading interp;
axis equal;
%colorbar;


function [fPlus,fCross] = fpfc_anal(theta,phi,psi)
% To obtain strain according to antenna pattern function
% s = h_p * F_p + h_c * F_c
F_p = 0.5*(1+cos(theta)^2)*cos(2*phi);
F_c = cos(theta)*sin(2*phi);
fPlus = F_p * cos(2*psi) - F_c*sin(2*psi);
fCross = F_p * sin(2*psi) + F_c* cos(2*psi);
end