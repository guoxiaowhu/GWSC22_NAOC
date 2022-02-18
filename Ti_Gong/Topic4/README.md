# Topic 4: Detection and Estimation of Signals in Noise

## Task 1: Use the Quadratic Noise PSD and Linear Chirp Signal

### PSD Shape

![Noise PSD](noisePSDVector1.png)

### Estimated SNR

![Estimated SNR](estimateSNR1.png)

### Noise Realization

![Estimated SNR](noiseRealization1.png)

### Data and Signal Realization

![Data and Signal Realization](datasignalRealization1.png)

### Periodogram of Data and Signal

![Periodogram of Data and Signal](periodogramSignalData1.png)

### Spectrogram of Data

![Spectrogram of Data](spectrogramData1.png)

## Task 2: Use the Initial LIGO Design Sensitivity PSD and Linear Chirp Signal

### PSD Shape

![Noise PSD](noisePSDVector2.png)

### Estimated SNR

![Estimated SNR](estimateSNR2.png)

### Noise Realization

![Estimated SNR](noiseRealization2.png)

### Data and Signal Realization

![Data and Signal Realization](datasignalRealization2.png)

### Periodogram of Data and Signal

![Periodogram of Data and Signal](periodogramSignalData2.png)

### Spectrogram of Data

![Spectrogram of Data](spectrogramData2.png)

## Task 3: Write a Function to Calculate the GLRT

### Here is the code [glrtqcsig.m](glrtqcsig.m).

## Task 4: Estimating Significance

### Using [significance.m](significance.m), we can get the following results for 10000 times data realization.

```MATLAB
For data1, The GLRT is 10.6069, and the significance under H0(signal absent) is 0.0015,
which means the probability being a pure noise is 0.15%, and the probability having a signal is 99.85%.

For data2, The GLRT is 71.4192, and the significance under H0(signal absent) is 0,
which means the probability being a pure noise is 0%, and the probability having a signal is 100%.

For data3, The GLRT is 2.7812, and the significance under H0(signal absent) is 0.0972,
which means the probability being a pure noise is 9.72%, and the probability having a signal is 90.28%.
```
