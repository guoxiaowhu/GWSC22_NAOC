function strain = Strain_F(h_p,h_c,theta,phi,psi)
% To obtain strain according to antenna pattern function
% s = h_p * F_p + h_c * F_c
[fPlus,fCross] = detframefpfc_psi(theta,phi,psi);
% strain = zeros(length(h_p));
for i = 1:length(h_p)
    strain(i) = h_p(i) * fPlus + h_c(i) * fCross;
end
 
end