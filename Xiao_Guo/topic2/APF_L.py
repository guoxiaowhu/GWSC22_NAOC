# -*- coding: utf-8 -*-
"""
Created on Fri Sep  2 11:43:28 2022

@author: Xiao GUO

Reference: 
Physics, Astrophysics and Cosmology
with Gravitational Waves
Living Rev. Relativity, 12, (2009), 2
    http://www.livingreviews.org/lrr-2009-2
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

def APF(theta_S,phi_S,theta_L,phi_L,n1=[1,0,0],n2=[0,1,0]):
    detTensor = detTen(n1,n2)
    
    vec2Src = DirVec(theta_S, phi_S)
    # Lvec is the normal vector of orbital angular momentum of binary
    Lvec = DirVec(theta_L,phi_L)
    
    Vec_z = np.cross(n1,n2) #np.array([0,0,1])
    xVec = np.cross(Vec_z,vec2Src)
    yVec = np.cross(xVec,vec2Src)
    #normalization
    xVec = xVec/norm(xVec)
    yVec = yVec/norm(yVec)
    #print(norm(xVec))
    #print(norm(yVec))

    ePlus = np.outer(xVec,xVec) - np.outer(yVec,yVec)
    eCross = np.outer(xVec,yVec) + np.outer(yVec,xVec)


    # find out psi
    priVec = np.cross(vec2Src,Lvec) # principal + direction
    priVec = priVec/norm(priVec) # yVec


    # psi is the angle from priVEc to yVec
    #sin_psi = np.cross(priVec,yVec)
    cos_psi = np.dot(priVec,yVec)
    psi = np.arccos(cos_psi)
    #print(psi)
    
    '''
    # another way to calculate psi
    T_psi_up = np.dot(Lvec,Vec_z) - np.dot(Lvec,vec2Src) * np.dot(Vec_z,vec2Src)
    T_psi_down = np.dot(vec2Src,np.cross(Lvec,Vec_z))  
    psi = np.arctan(T_psi_up/T_psi_down)
    print(psi)
    '''

    for i in range(3):
        for j in range(3):
            eNew = [ePlus[i,j],eCross[i,j]] * Rot_psi(psi)
            ePlus[i,j] = eNew[0,0]
            eCross[i,j] = eNew[0,1]

    F_plus = np.trace(np.dot(ePlus,detTensor))
    F_cross = np.trace(np.dot(eCross,detTensor))
    return F_plus,F_cross



    
     
    
    
    

#%%
theta_S = np.pi*np.random.random()
phi_S= 2*np.pi*np.random.random()
theta_L = np.pi*np.random.random()
phi_L= 2*np.pi*np.random.random()
print(APF(theta_S,phi_S,theta_L,phi_L))

