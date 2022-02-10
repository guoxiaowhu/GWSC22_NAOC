function [fPlusI,fCrossI,fPlusII,fCrossII]=detframefpfc_psi_LISA(polAngleTheta,polAnglePhi,psi)
%Antenna pattern functions in detector local frame (for LISA)
%[Fp,Fc]=DETFRAMEFPFC(T,P)
%Returns the antenna pattern function values Fp, Fc (corresponding to F_+
%and F_x respectively) for a given sky location in the local frame of a 
%90 degree equal arm length interferometer. The X and Y axes of the frame
%point along the arms. T is the polar angle (0 radians on the Z axis) and P
%is the azimuthal angle (0 radians on the X axis). T and P can be vectors
%(equal lengths), in which case Fp and Fc are also vectors with Fp(i) and
%Fc(i) corresponding to T(i) and P(i).


%Number of locations requested
nLocs = length(polAngleTheta);
if length(polAnglePhi) ~= nLocs
    error('Number of theta and phi values must be the same');
end

%Obtain the components of the unit vector pointing to the source location
sinTheta = sin(polAngleTheta(:));
vec2Src = [sinTheta.*cos(polAnglePhi(:)),...
           sinTheta.*sin(polAnglePhi(:)),...
           cos(polAngleTheta(:))];
       
%Get the wave frame vector components (for multiple sky locations if needed)
xVec = vcrossprod(repmat([0,0,1],nLocs,1),vec2Src);
yVec = vcrossprod(xVec,vec2Src);
%Normalize wave frame vectors
for lpl = 1:nLocs
    xVec(lpl,:) = xVec(lpl,:)/norm(xVec(lpl,:));
    yVec(lpl,:) = yVec(lpl,:)/norm(yVec(lpl,:));
end

%
n1=[1,0,0];
n2=[-1,sqrt(3),0]/2;
n3=[-1,-sqrt(3),0]/2;

%Detector tensor I of LISA arm interferometer 
detTensorI =0.5*(n1'*n1-n2'*n2);

%Detector tensor II of LISA arm interferometer 
detTensorII =(n1'*n1 + n2'*n2 - 2*n3'*n3)/(2*sqrt(3));

fPlusI = zeros(1,nLocs);
fCrossI = zeros(1,nLocs);
fPlusII = zeros(1,nLocs);
fCrossII = zeros(1,nLocs);

Rot_psi = [cos(2*psi),sin(2*psi);-sin(2*psi),cos(2*psi)];
%For each location ...
for lpl = 1:nLocs
    %ePlus eCross contraction with detector tensor
    ePlus = xVec(lpl,:)'*xVec(lpl,:)-yVec(lpl,:)'*yVec(lpl,:);
    eCross = xVec(lpl,:)'*yVec(lpl,:)+yVec(lpl,:)'*xVec(lpl,:);
    for i =1:3
        for j =1:3
             eNew =[ePlus(i,j),eCross(i,j)]*Rot_psi; 
             ePlus(i,j) = eNew(1);
             eCross(i,j)= eNew(2);
        end
    end    
    fPlusI(lpl) = sum(ePlus(:).*detTensorI(:));
    fCrossI(lpl) = sum(eCross(:).*detTensorI(:));
    
    fPlusII(lpl) = sum(ePlus(:).*detTensorII(:));
    fCrossII(lpl) = sum(eCross(:).*detTensorII(:));
end

