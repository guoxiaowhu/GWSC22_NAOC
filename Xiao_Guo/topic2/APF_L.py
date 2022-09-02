# -*- coding: utf-8 -*-
"""
Created on Fri Sep  2 11:43:28 2022

@author: Administrator
"""

import numpy as np
from numpy.linalg import norm

# L interferometer


def DirVec(theta,phi):
    return np.array([np.sin(theta)*np.cos(phi),np.sin(theta)*np.sin(phi),np.cos(theta)])
def Rot_psi(psi):
    return np.mat([[np.cos(2*psi),np.sin(2*psi)],[-np.sin(2*psi),np.cos(2*psi)]])

 
# detector tensor

def detTen(n1,n2):# detector tensor definition
    return (np.outer(n1,n1)-np.outer(n2,n2))/2.


# antenna pattern function

def APF(theta,phi,psi,n1=[1,0,0],n2=[0,1,0]):
    detTensor = detTen(n1,n2)
    
    vec2Src = DirVec(theta, phi)

    Vec_z = np.array([0,0,1])
    xVec = np.cross(Vec_z,vec2Src)
    yVec = np.cross(xVec,vec2Src)
    #normalization
    xVec = xVec/norm(xVec)
    xVec = xVec/norm(xVec)

    ePlus = np.outer(xVec,xVec) - np.outer(yVec,yVec)
    eCross = np.outer(xVec,yVec) + np.outer(yVec,xVec)

    for i in range(3):
        for j in range(3):
            eNew = [ePlus[i,j],eCross[i,j]] * Rot_psi(psi)
            ePlus[i,j] = eNew[0,0]
            eCross[i,j] = eNew[0,1]

    F_plus = np.trace(np.dot(ePlus,detTensor))
    F_cross = np.trace(np.dot(eCross,detTensor))
    return F_plus,F_cross

#%%
theta=1
phi=2
psi=1.5
print(APF(theta,phi,psi))