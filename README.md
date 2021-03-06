# GWSC22_NAOC
The repository for a Collaboration for the GWSC in 2022.

# Members
[郭潇（国台）](https://github.com/guoxiaowhu)、[张云龙（国台）](https://github.com/zhangyunlong001)、[赵悦同（国台）](https://github.com/LeonsZhao)、[程功（理论所）](https://github.com/chenggongphy)、[牟博（清华）](https://github.com/muboBASE)、[郭文渊（华南理工）](https://github.com/ralspi)、孙孟飞（重大）、孙厚义（华科）、[刘云龙（华南理工）](https://github.com/CKeXue)、朱经亚（河南大学）、郭盼（国科大）、[龚禔（河南大学）](https://github.com/ttigong)、宋仑（华科）、王博锐（重大）、罗智（重大）、李亚玲（南昌大学）、刘雨晨（南昌大学）、张明汇（重大）、[何显龙（武大）](https://github.com/chongzi14247)、袁泳（武大）

# Results
## Topic 1 (Signal Processing)
See also [_Ti_Gong's topic1_](https://github.com/guoxiaowhu/GWSC22_NAOC/tree/main/Ti_Gong/Topic1) and [_Yunlong_Liu's topic1_](https://github.com/guoxiaowhu/GWSC22_NAOC/tree/main/YunLong_Liu/Topic1)
### Signals
![Signals](https://raw.githubusercontent.com/guoxiaowhu/GWSC22_NAOC/main/Ralspi/topic1/result/signal%20figure2.png)
from Wenyuan Guo (ralspi)
### Spectrogram
FFT
![FFT](https://raw.githubusercontent.com/guoxiaowhu/GWSC22_NAOC/main/Ralspi/topic1/result/spectrogram-fft4.png)
from Wenyuan Guo (ralspi)

Time-frequency relation
![Spe](https://raw.githubusercontent.com/guoxiaowhu/GWSC22_NAOC/main/Ralspi/topic1/result/spectrogram4.png)
from Wenyuan Guo (ralspi)

### Filtering 
With the filter designed by us in [_ThreeSignalsFiltering.m_](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/topic1/ThreeSignalsFiltering.m), we can filter signals _s_ into three signals:
![filter](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/figs/filter.png?raw=true)
where red line represents the filtered signals, blue line represents the orginal signal.

## Topic 2 (GW Signals)
We can see the folder [_GWSIG_](https://github.com/guoxiaowhu/GWSC_NAOC/tree/main/GWSIG) for previous results
### Antenna Pattern Function (APF)
With the code [_testdetframefpfc_psi.m_](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/topic2/testdetframefpfc_psi.m), we can plot APF as
![APF](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/figs/APF_psi.png?raw=true)
### Strain
For a sine signal,
![sin](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/figs/sinStrain.png?raw=true)
### LISA
Accoring to Soumya D. Mohanty's code, using code [_LISA_animation.m_](https://github.com/guoxiaowhu/GWSC_NAOC/blob/main/GWSIG/LISA_animation.m), combining its APF, we can plot a GIF file to show the orbit and APF of LISA
![LISA orbit APF](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/YunLong_Liu/LISA_antenna_pattern.gif?raw=true)
from Yunlong Liu.

An example of APF of LISA as the function of position (phase Phi) of LISA for two TDI detector tensor I and II under a centrain source location (theta, phi) with code [_testdetframefpfc_psi_LISA.m_](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/topic2/testdetframefpfc_psi_LISA.m)
![LISA_APF](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/figs/APF_LISA.png?raw=true)
For a sine h+ and hx signal, its response is shown as (without Doppler effect)
![LISA_response](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/figs/response_LISA.png?raw=true)

## Topic 3 (Noise)
We can see the folder [_NOISE_](https://github.com/guoxiaowhu/GWSC_NAOC/tree/main/NOISE)

## Topic 4 (The signal detection and estimation in noise)
For sine signal, for 1000 realizations,
![SNR](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Mu_Bo/lab4/set1/pic2.jpg?raw=true)
from MU Bo.

![sig noise](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Mu_Bo/lab4/set1/pic4.jpg?raw=true)
from MU Bo.

For LTC signal,
![FFT LTC](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/figs/FFT_LTC.png?raw=true)
![Spe LTC](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/figs/spe_LTC_n.png?raw=true)

Also see [_Ti_Gong's topic4_](https://github.com/guoxiaowhu/GWSC22_NAOC/tree/main/Ti_Gong/Topic4) and [_Mu Bo's lab4 set4_](https://github.com/guoxiaowhu/GWSC22_NAOC/tree/main/Mu_Bo/lab4/set4)
## Topic 5 (GLRT Optimization)
With _test\_crcbpso.m_
fitness function is Sigma\_i((x\_i-35.5)^2-10*cos(2*pi*x)+10)
![Best Locs](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/figs/BestLocs.png?raw=true)
The best location is (35.0025, 35.0025)

Use _test\_crcbqcpso.m_ to find signal,
![qcsignal](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/figs/qcsig.png?raw=true)
Estimated parameters: a1=9.6224; a2=4.2643; a3=2.048


## Topic 6 (Application)
Modified the codes from [He Wang's PSO python demo](https://github.com/iphysresearch/PSO_python_demo), for data TrainingData.mat and analysisData.mat, using code [_demo.ipynb_](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/topic6/demo.ipynb)  we can find the signal, with parameters a1=51.3605915101784; a2=28.832078856931652; a3=10.308191421692223; SNR=9.056993402304737. And the signal is shown as
![signal](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/figs/output_sig.png?raw=true)
For data TrainingDataTF.mat and AnalysisDataTF.mat, using code [_demo-TF.ipynb_](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/topic6/demo-TF.ipynb) we can find the signal, with parameters a1=51.73239824255724; a2=28.361217432284324; a3=10.454001420382449; SNR=15.087237883981299. And the signal is shown as
![signalTF](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/figs/output_sigTF.png?raw=true)

(key: a1=50;a2=30;a3=10 SNR=8.4 or 15(TF) from Xiaobo)
# References
Some lecture notes can see [this link](https://note.youdao.com/ynoteshare/index.html?id=ad50ed7fa5f67565dce3dfd9b68e0a00&type=note&_time=1644224870530). 
Codes can refer to [Soumya D. Mohanty](https://github.com/mohanty-sd)'s [GWSC](https://github.com/mohanty-sd/GWSC), and [DATASCIENCE_COURSE](https://github.com/mohanty-sd/DATASCIENCE_COURSE). Some codes and materials can also see [GWSC_NAOC](https://github.com/guoxiaowhu/GWSC_NAOC) in last year.

The repositories for other groups are [GWSC22-LNNU-ET-AL](https://github.com/octogen4/GWSC22-LNNU-ET-AL) and [
GravitionalWaves](https://github.com/jinshuzhu1999/GravitionalWaves).
