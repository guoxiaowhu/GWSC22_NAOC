import numpy as np
from scipy.fftpack import fft 
# Why this 'fft'? 
# See: https://iphysresearch.github.io/blog/post/signal_processing/fft/#efficiency-of-the-algorithms

from tqdm import tqdm
# from numba import jit
# from numba import njit, prange

__all__ = ['crcbqcpsopsd', 
           'crcbpso', 
           'crcbgenqcsig', 
           'glrtqcsig4pso',
           'ssrqc',
           'normsig4psd',
           'innerprodpsd',
           's2rv',
           'crcbchkstdsrchrng']
print("""
Loading demo codes modified by He Wang [https://iphysresearch.github.io/]
For original codes, see SDMBIGDAT19 (MATLAB) delivered by Soumya D. Mohanty
[https://github.com/mohanty-sd/SDMBIGDAT19]
""")

# @jit(nopython=True, parallel=True)
def crcbqcpsopsd(inParams, psoParams, nRuns):
    """
    Regression of quadratic chirp using PSO
    O = CRCBQCPPSOPSD(I,P,N)
    I is the input dict with the fields given below.
    The fields of I are:
    'dataY': The data vector (a uniformly sampled time series).
    'dataX': The time stamps of the data samples.
    'dataXSq': dataX.^2
    'dataXCb': dataX.^3
    'psd': PSD values at positive DFT frequencies
    'sampFreq': Sampling frequency
    rmin', 'rmax': The minimum and maximum values of the three parameters
                    a1, a2, a3 in the candidate signal:
                    a1 * dataX + a2 * dataXSq + a3 * dataXCb
    P is the PSO parameter dict. Setting P to [] will invoke default 
    parameters (see CRCBPSO). N is the number of independent PSO runs. 
    The output is returned in the dict O.
    The fields of O are:
    'allRunsOutput': An N element dict array containing results from each PSO
                 run. The fields of this dict are:
                    'fitVal': The fitness value.
                    'qcCoefs': The coefficients [a1, a2, a3].
                    'estSig': The estimated signal.
                    'totalFuncEvals': The total number of fitness
                                      evaluations.
    'bestRun': The best run.
    'bestFitness': best fitness from the best run.
    'bestSig' : The signal estimated in the best run.
    'bestQcCoefs' : [a1, a2, a3] found in the best run.

    He Wang, Mar 2021    
    """
    nSamples = len(inParams['dataX'])
    fHandle = lambda x, returnxVec: glrtqcsig4pso(x, inParams, returnxVec)
    
    nDim = 3
    outStruct = {
        'bestLocation': [],
        'bestFitness': [],
        'totalFuncEvals': [],
    }

    outResults = {
        'allRunsOutput': [],
        'bestRun': [],
        'bestRun': [],
        'bestRun': [],
        'bestFitness': [],
        'bestSig': np.zeros(nSamples),
        'bestQcCoefs': np.zeros(3),
    }

    # Allocate storage for outputs: results from all runs are stored
    outStruct = [outStruct for _ in range(nRuns)]
    
    # Independent runs of PSO [TODO: runing in parallel.]
    for lpruns in range(nRuns):
        # Reset random number generator for each run
        np.random.seed(lpruns)
        outStruct[lpruns] = crcbpso(fHandle,nDim,**psoParams)
        # Below codes are used for checking qcCoefs for current lprun.
        #_, qcCoefs = fHandle(outStruct[lpruns]['bestLocation'][np.newaxis,...], returnxVec=1)
        #print(qcCoefs)

    #Prepare output
    fitVal = np.zeros(nRuns)
    for lpruns in range(nRuns):
        allRunsOutput = {
                'fitVal': 0,
                'qcCoefs': np.zeros(3),
                'estSig': np.zeros(nSamples),
                'totalFuncEvals': [],
            }
        fitVal[lpruns] = outStruct[lpruns]['bestFitness']
        allRunsOutput['fitVal'] = fitVal[lpruns]

        _, qcCoefs = fHandle(outStruct[lpruns]['bestLocation'][np.newaxis,...], returnxVec=1)
        allRunsOutput['qcCoefs'] = qcCoefs[0]

        estSig = crcbgenqcsig(inParams['dataX'], 1, qcCoefs[0])
        estSig, _ = normsig4psd(estSig, inParams['sampFreq'], inParams['psdPosFreq'], 1)
        estAmp = innerprodpsd(inParams['dataY'], estSig, inParams['sampFreq'], inParams['psdPosFreq'])
        estSig = estAmp*estSig

        allRunsOutput['estSig'] = estSig
        allRunsOutput['totalFuncEvals'] = outStruct[lpruns]['totalFuncEvals']
        outResults['allRunsOutput'].append(allRunsOutput)

    #Find the best run
    bestRun = np.argmin(fitVal)
    outResults['bestRun'] = bestRun
    outResults['bestFitness'] = outResults['allRunsOutput'][bestRun]['fitVal']
    outResults['bestSig'] = outResults['allRunsOutput'][bestRun]['estSig']
    outResults['bestQcCoefs'] = outResults['allRunsOutput'][bestRun]['qcCoefs']
    return outResults, outStruct


# @jit(nopython=True, parallel=True)
def crcbpso(fitfuncHandle, nDim, O=0, **varargin):
    """
    Local-best (lbest) PSO minimizer 
    S=CRCBPSO(Fhandle,N)
    Runs local best PSO on the fitness function with handle Fhandle. If Fname
    is the name of the function, Fhandle = @(x) <Fname>(x, FP).  N is the
    dimensionality of the  fitness function.  The output is returned in the
    structure S. The field of S are:
      'bestLocation : Best location found (in standardized coordinates)
      'bestFitness': Best fitness value found
      'totalFuncEvals': Total number of fitness function evaluations. This can
                       be less than the product of the number of iterations
                       and the number of particles since particles can leave
                       and re-enter the search space.

    S=CRCBPSO(Fhandle,N,P)
    overrides the default PSO parameters with those provided in structure P.
    Set any of the fields of P to [] in order to invoke the corresponding
    default value. The fields of P are as follows.
         'popSize': Number of PSO particles
         'maxSteps': Number of iterations for termination
         'c1','c2': acceleration constant
         'maxVelocity': maximum value for each velocity component for all
                         subsequent iterations
         'startInertia': Starting value of inertia weight
         'endInertia': End value of inertia at iteration# <maxSteps>
         'boundaryCond': Set to '' for the "let them fly" boundary condition.
                         Any other value is passed onto the fitness function
                         for further processing. 
         'nbrhdSz' : Number of particles in a ring topology neighborhood.
                     Reset to 3 if less than 3.
    Setting P to [] will invoke the default values for all pso parameters.
    NOTE: The optional P argument is normally to be used only for testing and
    debugging (e.g., reduce the number of particles and/or iterations for a
    quick run). Baseline default values are hardcoded in this function.

    S = CRCBPSO(Fhandle,N,P,O)
    O is an integer that controls the amount of information returned in S. The
    default value of O is zero and returns S as the dict defined above.
    Progressively higher values of O increase the number of fields in S as
    listed below.
       'allBestFit': O = 1. Best fitness values for all iterations returned as a vector.
       'allBestLoc': O = 2. Best locations in standardized coordinates for all
                     iterations returned as a row of a matrix. 

    Example:
    nDim = 5;
    fitFuncParams = dict(rmin=-5*np.ones((1,nDim)),
                         rmax=5*np.ones((1,nDim)))
    fitFuncHandle = lambda x, returnxVec: crcbpsotestfunc(x,fitFuncParams,returnxVec)
    psoOut = crcbpso(fitFuncHandle,0);

    Authors
    Soumya D. Mohanty, Dec 2018
    Adapted from LDACSchool/ldacpso.m

    He Wang 
    Mar 2021: Adapted for python

    Baseline (also default) PSO parameters
    """

    psoParams = dict(
        popsize=40,
        popSize=40, # Just in case
        maxSteps=2000,
        c1=2,
        c2=2,
        max_velocity = 0.5,
        maxVelocity = 0.5, # Just in case
        dcLaw_a = 0.9,
        startInertia = 0.9, # Just in case
        dcLaw_b = 0.4,
        endInertia = 0.4, # Just in case
        dcLaw_c = 2000-1, #maxSteps-1
        dcLaw_d = 0.2,
        bndryCond = '',
        boundaryCond = '', # Just in case
        nbrhdSz = 3,    
    )
    
    #Default for the level of information returned in the output
    outputLvl = 0
    returnData = {
        'totalFuncEvals': [],
        'bestLocation': np.zeros((1,nDim)),
        'bestFitness': [],
    }

    #Override defaults if needed
    nreqArgs = 2   # Not used (He Wang)
    
    psoParams.update(varargin)
    psoParams['popsize'] = psoParams.pop('popSize')    
    psoParams['max_velocity'] = psoParams.pop('maxVelocity')
    psoParams['dcLaw_a'] = psoParams.pop('startInertia')
    psoParams['dcLaw_b'] = psoParams.pop('endInertia')
    psoParams['bndryCond'] = psoParams.pop('boundaryCond')
    # Neither maxInitialVelocity nor max_initial_velocity is used here.
    
    if O==1:
        returnData['allBestFit'] = np.zeros(psoParams['maxSteps'])
    elif O==2:
        returnData['allBestLoc'] = np.zeros((psoParams['maxSteps'],nDim))
    #Add more fields with additional case
    assert O<=2, 'Output level > 2 not implemented'    
    
    
    #Number of left and right neighbors. Even neighborhood size is split
    #asymmetrically: More right side neighbors than left side ones.
    psoParams['nbrhdSz'] = max([psoParams['nbrhdSz'],3])
    leftNbrs = np.floor((psoParams['nbrhdSz']-1)/2)  # Not used (He Wang)
    rightNbrs = psoParams['nbrhdSz']-1-leftNbrs      # Not used (He Wang)

    #Information about each particle stored as a row of a matrix ('pop').
    #Specify which column stores what information.
    #(The fitness function for matched filtering is SNR, hence the use of 'snr'
    #below.)
    partCoordCols = np.arange(nDim) # Particle location
    partVelCols = np.arange(nDim,2*nDim) # Particle velocity
    partPbestCols = np.arange(2*nDim,3*nDim) # Particle pbest
    partFitPbestCols = 3*nDim # Fitness value at pbest
    partFitCurrCols = partFitPbestCols+1 # Fitness value at current iteration
    partFitLbestCols = partFitCurrCols+1 # Fitness value at local best location
    partInertiaCols = partFitLbestCols+1 # Inertia weight
    partLocalBestCols = np.arange(partInertiaCols,partInertiaCols+nDim) # Particles local best location
    partFlagFitEvalCols = partLocalBestCols[-1]+1 # Flag whether fitness should be computed or not
    partFitEvalsCols = partFlagFitEvalCols+1 # Number of fitness evaluations

    nColsPop = len(sum([partCoordCols.tolist(),partVelCols.tolist(),partPbestCols.tolist(),  
                        [partFitPbestCols,partFitCurrCols,partFitLbestCols,partInertiaCols],
                        partLocalBestCols.tolist(),
                        [partFlagFitEvalCols,partFitEvalsCols]], []) )
    pop = np.zeros((psoParams['popsize'],nColsPop))

    # Best value found by the swarm over its history
    gbestVal = np.inf
    # Location of the best value found by the swarm over its history
    gbestLoc = 2 * np.ones((1,nDim)) # Init values for > (0,1)
    # Best value found by the swarm at the current iteration
    bestFitness = np.inf

    pop[:,partCoordCols] = np.random.rand(psoParams['popsize'],nDim)
    pop[:,partVelCols] = -pop[:,partCoordCols] + np.random.rand(psoParams['popsize'],nDim)
    pop[:,partPbestCols] = pop[:,partCoordCols]
    pop[:,partFitPbestCols]= np.inf
    pop[:,partFitCurrCols]=0
    pop[:,partFitLbestCols]= np.inf
    pop[:,partLocalBestCols] = 0
    pop[:,partFlagFitEvalCols]=1
    pop[:,partInertiaCols]=0
    pop[:,partFitEvalsCols]=0

    #Start PSO iterations ...
    for lpc_steps in tqdm(range(psoParams['maxSteps'])):
        #Evaluate particle fitnesses under ...
        if not psoParams['bndryCond']:
            #Invisible wall boundary condition
            fitnessValues = fitfuncHandle(pop[:,partCoordCols], returnxVec=0);
        else:
            #Special boundary condition (handled by fitness function)
            fitnessValues, pop[:,partCoordCols] = fitfuncHandle(pop[:,partCoordCols], returnxVec=1)
            
        #Fill pop matrix ...(for each partical; update FitCurr/FitEvals/FitPbest/Pbest)
        for k in range(psoParams['popsize']):
            pop[k, partFitCurrCols] = fitnessValues[k]
            computeOK = pop[k,partFlagFitEvalCols]
            funcCount = 1 if computeOK else 0
            pop[k,partFitEvalsCols] = pop[k,partFitEvalsCols] + funcCount
            if pop[k,partFitPbestCols] > pop[k,partFitCurrCols]:
                pop[k,partFitPbestCols] = pop[k,partFitCurrCols]
                pop[k,partPbestCols] = pop[k,partCoordCols]

        #Update gbest
        bestFitness, bestParticle = np.min(pop[:,partFitCurrCols]), np.argmin(pop[:,partFitCurrCols])
        if gbestVal > bestFitness:
            gbestVal = bestFitness
            gbestLoc = pop[bestParticle, partCoordCols]
            pop[bestParticle,partFitEvalsCols] = pop[bestParticle,partFitEvalsCols] + funcCount # Why ?

        #Local bests ...
        for k in range(psoParams['popsize']):
            #Get indices of neighborhood particles
            ringNbrs = np.roll(np.arange(psoParams['popsize']), shift=-k+1)[:psoParams['nbrhdSz']]

            #Get local best in neighborhood
            lbestPart = np.argmin(pop[ringNbrs,partFitCurrCols]) # get local indices in neighborhood
            lbestTruIndx = ringNbrs[lbestPart] # get global indices in pop
            lbestCurrSnr = pop[lbestTruIndx, partFitCurrCols]

            if lbestCurrSnr < pop[k,partFitLbestCols]:
                pop[k,partFitLbestCols] = lbestCurrSnr
                pop[k,partLocalBestCols] = pop[lbestTruIndx, partCoordCols]

        #Inertia decay (0.9~>0.2)
        inertiaWt = np.max([psoParams['dcLaw_a']-(psoParams['dcLaw_b']/psoParams['dcLaw_c'])*lpc_steps,
                            psoParams['dcLaw_d']])

        #Velocity updates ...
        for k in range(psoParams['popsize']):
            partInertia = pop[k,partInertiaCols] = inertiaWt
            chi1, chi2 = np.random.rand(nDim), np.random.rand(nDim)
            # PSO Dynamical Equation (Core)
            pop[k, partVelCols] = partInertia * pop[k,partVelCols] +\
                                psoParams['c1'] * (pop[k,partPbestCols] - pop[k,partCoordCols]) * chi1 +\
                                psoParams['c2'] * (pop[k,partLocalBestCols] - pop[k,partCoordCols])*chi2
            pop[k, partVelCols] = np.clip(pop[k, partVelCols], 
                                         -psoParams['max_velocity'], 
                                          psoParams['max_velocity'])
            pop[k,partCoordCols] = pop[k,partCoordCols] + pop[k,partVelCols]
            if np.any(pop[k,partCoordCols]<0) or np.any(pop[k,partCoordCols]>1):
                pop[k,partFitCurrCols]= np.inf
                pop[k,partFlagFitEvalCols]= 0
            else:
                pop[k,partFlagFitEvalCols]=1

        #Record extended output if needed
        if O==1:
            returnData['allBestFit'][lpc_steps] = gbestVal
        elif O==2:
            returnData['allBestLoc'][lpc_steps,:] = gbestLoc
        #Add more fields with additional case
        #statements

    actualEvaluations = np.sum(pop[:,partFitEvalsCols])

    #Prepare main output
    returnData['totalFuncEvals'] = actualEvaluations
    returnData['bestLocation'] = gbestLoc
    returnData['bestFitness'] = gbestVal
    return returnData

def crcbgenqcsig(dataX, snr, qcCoefs):
    """
    Generate a quadratic chirp signal
    S = CRCBGENQSIG(X, SNR, C)
    Generates a quadratic chirp signal S. X is the vector of
    time stamps at which the samples of the signal are to be computed. SNR is
    the matched filtering signal-to-noise ratio of S and C is the vector of
    three coefficients [a1, a2, a3] that parametrize the phase of the signal:
    a1*t + a2*t^2 + a3*t^3. 

    Soumya D. Mohanty, May 2018

    He Wang, Mar 2021
    """

    phaseVec = qcCoefs[0]*dataX + qcCoefs[1]*dataX**2 + qcCoefs[2]*dataX**3
    sigVec = np.sin(2*np.pi*phaseVec)
    sigVec = snr*sigVec/np.linalg.norm(sigVec)
    return sigVec



def glrtqcsig4pso(xVec, params, returnxVec=0):
    """
    Fitness function for quadratic chirp regression
    F = GLRTQCSIG4PSO(X,P,O)
    Compute the fitness function (log-likelihood ratio for colored noise maximized
    over the amplitude parameter) for data containing the quadratic chirp signal. X.
    The fitness values are returned in F. X is standardized, that is 0<=X[i,j]<=1. 
    The fields P.rmin and P.rmax are used to convert X[i,j] internally 
    before computing the fitness:
    X[:,j] -> X[:,j]*(rmax[j]-rmin[j])+rmin[j].
    The fields P.dataY and P.dataX are used to transport the data and its
    time stamps. The fields P.dataXSq and P.dataXCb contain the timestamps
    squared and cubed respectively.
    An extra field P.psdPosFreq is to supply the PSD for colored noise.
    An extra filed P.sampFreq is the sampling rate.

    [F,] = GLRTQCSIG4PSO(X,P,O=0)
    returns the quadratic chirp coefficients corresponding to the rows of X in R. 
    Coverts standardized to real (unstandardized) coordinates, i.e., the
    parameters a1, a2, and a3.

    [F,S] = GLRTQCSIG4PSO(X,P,O=1)
    Returns the quadratic chirp signals corresponding to the rows of X in S. 
    Coverts the real coordinates to QC signal time series.

    Soumya D. Mohanty
    June, 2011
    April 2012: Modified to switch between standardized and real coordinates.

    Shihan Weerathunga
    April 2012: Modified to add the function rastrigin.

    Soumya D. Mohanty
    May 2018: Adapted from rastrigin function.

    Soumya D. Mohanty
    Adapted from QUADCHIRPFITFUNC
    
    He Wang
    Mar 2021: Adapted for python
    """
    # rows: points
    # columns: coordinates of a point
    nVecs, _ = xVec.shape

    # storage for fitness values
    fitVal = np.zeros(nVecs)

    # Check for out of bound coordinates and flag them
    validPts = crcbchkstdsrchrng(xVec)
    # Set fitness for invalid points to infty
    fitVal[~validPts] = np.inf
    xVec[validPts,:] = s2rv(xVec[validPts,:], params)

    for lpc in range(nVecs):
        if validPts[lpc]:
        # Only the body of this block should be replaced for different fitness
        # functions
            x = xVec[lpc,:]
            fitVal[lpc] = ssrqc(x, params)

    # https://stackoverflow.com/questions/14147675/nargout-in-python
    #Return real coordinates if requested
    if returnxVec:
        return fitVal, xVec
    else:
        return fitVal

# Sum of squared residuals after maximizing over amplitude parameter
def ssrqc(x, params):
    """
    Generate normalized quadratic chirp
    More efficient if the signal is generated inside this function for speed  
    
    He Wang
    Mar 2021: Adapted for python    
    """

    phaseVec = x[0]*params['dataX'] + x[1]*params['dataXSq'] + x[2]*params['dataXCb']
    qc = np.sin(2 * np.pi * phaseVec)
    qc, _ = normsig4psd(qc, params['sampFreq'], params['psdPosFreq'], 1)
    #We do not need the normalization factor, just the need template vector

    #Compute fitness (Calculate inner product of data with template qc）
    inPrd = innerprodpsd(params['dataY'], qc, params['sampFreq'], params['psdPosFreq'])
    ssrVal = -(inPrd)**2
    return ssrVal

def normsig4psd(sigVec, sampFreq, psdVec, snr):
    """
    Normalize a given signal to have a specified SNR in specified noise PSD
    [NS,NF]=NORMSIG4PSD(S,Fs,Sn,SNR)
    S is the signal vector to be normalized to have signal to noise ratio SNR
    in noise with PSD specified by vector Sn. The PSD should be specified at
    the positive DFT frequencies corresponding to the length of S and
    sampling frequency Fs. The normalized signal vector is returned in NS and
    the normalization factor is returned in NF.

    Soumya D. Mohanty, Mar 2019

    He Wang
    Mar 2021: Adapted for python

    PSD length must be commensurate with the length of the signal DFT 
    """
    
    nSamples = len(sigVec)
    kNyq = np.floor(nSamples/2) + 1
    assert len(psdVec) == kNyq, 'Length of PSD is not correct'

    # Norm of signal squared is inner product of signal with itself
    normSigSqrd = innerprodpsd(sigVec,sigVec,sampFreq,psdVec);
    # Normalization factor
    normFac = snr/np.sqrt(normSigSqrd)
    # Normalize signal to specified SNR
    normSigVec = normFac * sigVec
    return normSigVec, normFac

def innerprodpsd(xVec,yVec,sampFreq,psdVals):
    """
    P = INNERPRODPSD(X,Y,Fs,Sn)
    Calculates the inner product of vectors X and Y for the case of Gaussian
    stationary noise having a specified power spectral density. Sn is a vector
    containing PSD values at the positive frequencies in the DFT of X
    and Y. The sampling frequency of X and Y is Fs.

    Soumya D. Mohanty, Mar 2019

    He Wang
    Mar 2021: Adapted for python
    """
    
    nSamples = len(xVec)
    assert len(yVec) == nSamples, 'Vectors must be of the same length'
    kNyq = np.floor(nSamples/2)+1
    assert len(psdVals) == kNyq, 'PSD values must be specified at positive DFT frequencies'
    
    # Why 'scipy.fftpack.fft'? 
    # See: https://iphysresearch.github.io/blog/post/signal_processing/fft/#efficiency-of-the-algorithms
    fftX = fft(xVec)
    fftY = fft(yVec)
    #We take care of even or odd number of samples when replicating PSD values
    #for negative frequencies
    negFStrt = 1 - np.mod(nSamples, 2)
    psdVec4Norm = np.concatenate((psdVals, psdVals[(kNyq.astype('int')-negFStrt)-1:0:-1]))
    
    dataLen = sampFreq * nSamples
    innProd = np.sum((1/dataLen) * (fftX / psdVec4Norm)*fftY.conj())
    innProd = np.real(innProd)
    return innProd

def s2rv(xVec, params):
    """
    Convert standardized coordinates to real using non-uniform range limits
    R = S2RV(X,P)
    Takes standardized coordinates in X (coordinates of one point per row) and
    returns real coordinates in R using the range limits defined in P.rmin and
    P.rmax. The range limits can be different for different dimensions. (If
    they are same for all dimensions, use S2RS instead.)

    Soumya D. Mohanty
    April 2012

    He Wang
    Mar 2021: Adapted for python    
    """
    return xVec * (np.asarray(params['rmax']) - np.asarray(params['rmin'])) + np.asarray(params['rmin'])

    # Pedagogic version:
    nrows, ncols = xVec.shape
    rVec = np.zeros((nrows, ncols))
    rmin = params['rmin']
    rmax = params['rmax']
    rngVec = rmax - rmin
    for lp in range(nrows):
        rVec[lp,:] = xVec[lp,:] * rngVec + rmin
    return rVec

def crcbchkstdsrchrng(xVec):
    """
    Checks for points that are outside the standardized search range 
    V = CRCBCHKSTDSRCHRNG(X)
    Returns an array of logical indices V corresponding to valid/invalid
    points in X. A row (point) of X is invalid if any of the coordinates
    (columns for that row) fall outside the closed interval [0,1].
    Do Y = X[V,:] to retrieve only the valid rows or Y = X[~V,:] to retrieve
    invalid rows.

    Soumya D. Mohanty
    April 2012
    
    He Wang
    Mar 2021: Adapted for python
    """
    return np.array([False if np.any(xVec[lp]<0) or np.any(xVec[lp]>1) else True for lp in range(xVec.shape[0])])

    # Pedagogic version:
    nrows, _ = xVec.shape
    validPts = np.ones(nrows)
    for lp in range(nrows):
        x = xVec[lp,:]
        if np.any(x<0) or np.any(x>1):
            #Mark point as invalid
            validPts[lp] = 0
    return validPts.astype('bool')