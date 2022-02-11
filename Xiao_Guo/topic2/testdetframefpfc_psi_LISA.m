%% F_+ and F_x calculation for LISA
%Polar angle
theta = 1;
%Azimuthal angle
phi = 1.5;
%polarization angle
psi = 1;

[Phi, E, Sp1path, Sp2path, Sp3path, C_total, Spsup, Spinf,R] = simu_LISA_orbits();


[fPlusI,fCrossI,fPlusII,fCrossII] = detframefpfc_psi_LISA(Sp1path, Sp2path,Sp3path,theta,phi,psi);
%Plot
figure;
set(gcf,'position',[0,0,600,400])
hold on
title('APF for LISA TDI I & II')
plot(Phi,fPlusI,'r','linewidth',3);
plot(Phi,fCrossI,'g','linewidth',3);
plot(Phi,fPlusII,'-.r','linewidth',3);
plot(Phi,fCrossII,'-.g','linewidth',3);
legend('F_{+,I}','F_{\times,I}','F_{+,II}','F_{\times,II}','location','SouthWest');
xlabel('phase \Phi');
ylabel('F_{+ or \times}');
xlim([0,2*pi])

