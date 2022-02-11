import numpy as np
import scipy.io as scio # load mat file
from scipy.signal import welch, filtfilt
from scipy.interpolate import interp1d

from PSO import *  # demo PSO codes!

import matplotlib
matplotlib.use('agg') # Must be before importing matplotlib.pyplot or pylab!
import matplotlib.pyplot as plt

if __name__ == '__main__':

    # load data
    TrainingData = scio.loadmat('TrainingData.mat')
    analysisData = scio.loadmat('analysisData.mat')

    ## Preparing
    dataY = analysisData['dataVec'][0] # (2048,)
    # Data length
    nSamples = dataY.size # 2048
    # Sampling frequency
    Fs = analysisData['sampFreq'][0,0] # 1024

    # Search range of phase coefficients
    rmin = [40, 1, 1]
    rmax = [100, 50, 15]

    # Noise realization: PSD estimated from TrainingData
    dt = 1/Fs
    t = np.arange(0, nSamples*dt, dt) # (2048,)
    T = nSamples/Fs
    df = 1/T
    Nyq = Fs/2 # Nyquist frequency
    f = np.arange(0, Nyq+df, df) # Not used...(Herb)
    [f, pxx] = welch(TrainingData['trainData'][0], fs=Fs, 
                     window='hamming', nperseg=Fs/2, 
                     noverlap=None, nfft=None, 
                     detrend=False) 
    # Why 'detrend=False'? 
    # See https://github.com/scipy/scipy/issues/8045#issuecomment-337319294
    # or https://iphysresearch.github.io/blog/post/signal_processing/spectral_analysis_scipy/

    # Smooth the PSD estimate
    smthOrdr = 10
    b = np.ones(smthOrdr)/smthOrdr
    pxxSmth = filtfilt(b,1,pxx)
    # PSD must be supplied at DFT frequencies.
    kNyq = np.floor(nSamples/2) + 1
    posFreq = np.arange(0, kNyq)*Fs/nSamples
    psdPosFreq = interp1d(f,pxxSmth)(posFreq)

    # Plot PSDs for the noise and noise + signal.
    plt.figure()
    plt.plot(f,pxx, label='noise')
    plt.plot(f,pxxSmth, label='noise (smoth)')
    [f, pxxY] = welch(dataY, fs=Fs, 
                     window='hamming', nperseg=256, 
                     noverlap=None, nfft=None, 
                     detrend=False)
    plt.plot(f,pxxY, label='noise + signal')
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('PSD')
    plt.legend()
    plt.savefig('output_psd.png', dpi=200)


    # Number of independent PSO runs
    nRuns = 8

    ## PSO
    # Input parameters for CRCBQCHRPPSO
    inParams = {
        'dataX': t,
        'dataY': dataY,
        'dataXSq': t**2,
        'dataXCb': t**3,
        'psdPosFreq': psdPosFreq,
        'sampFreq': Fs,
        'rmin': rmin,
        'rmax': rmax,
    }
    # CRCBQCHRPPSOPSD runs PSO on the CRCBQCHRPFITFUNC fitness function. As an
    # illustration of usage, we change one of the PSO parameters from its
    # default value.
    outResults, outStruct = crcbqcpsopsd(inParams, {'maxSteps': 2000}, nRuns)

    ## Plot sig
    fig = plt.figure()
    ax = fig.add_subplot(111)
    a=ax.scatter(t, dataY, marker='.', s=5, #label='analysisData'
                 )
    a.set_label('analysisData')
    for lpruns in range(nRuns):
        b,=ax.plot(t, outResults['allRunsOutput'][lpruns]['estSig'],
                 color=[51/255,255/255,153/255], lw=.4*2)
    b.set_label('estSig')
    c,=ax.plot(t, outResults['bestSig'], #label='BestSig',
             color=[76/255,153/255,0/255],lw=.2*2)
    c.set_label('BestSig')
    plt.legend()
    plt.savefig('output_sig.png', dpi=200)

    # Print estimated parameters
    print('Estimated parameters: a1={}; a2={}; a3={}'.format(outResults['bestQcCoefs'][0],
                                                             outResults['bestQcCoefs'][1],
                                                             outResults['bestQcCoefs'][2]))
    for lpruns in range(nRuns):
        print('Run No.{}:\nbestFitness={:.2f}'.format(lpruns+1, outStruct[lpruns]['bestFitness']) )
        print('a1={:.4f}; a2={:.4f}; a3={:.4f}'.format(outResults['allRunsOutput'][lpruns]['qcCoefs'][0],
                                           outResults['allRunsOutput'][lpruns]['qcCoefs'][1],
                                           outResults['allRunsOutput'][lpruns]['qcCoefs'][2]))    
    # Save
    np.save('output_results',outResults)
    np.save('output_struct',outStruct)
