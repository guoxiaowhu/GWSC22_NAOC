# GWSC22_NAOC
The repository for a Collaboration for the GWSC in 2022.

# Members
[郭潇（国台）](https://github.com/guoxiaowhu)、[张云龙（国台）](https://github.com/zhangyunlong001)、[赵悦同（国台）](https://github.com/LeonsZhao)、[程功（理论所）](https://github.com/chenggongphy)、[牟博（清华）](https://github.com/muboBASE)、[郭文渊（华南理工）](https://github.com/ralspi)、孙孟飞（重大）、孙厚义（华科）、[刘云龙（华南理工）](https://github.com/CKeXue)、朱经亚（河南大学）、郭盼（国科大）、[龚禔（河南大学）](https://github.com/ttigong)、宋仑（华科）、王博锐（重大）、罗智（重大）、李亚玲（南昌大学）、刘雨晨（南昌大学）、张明汇（重大）、何显龙（武大）、袁泳（武大）

# Results
## Topic 1 (Signal Processing)
See also [_Ti_Gong_'s results](https://github.com/guoxiaowhu/GWSC22_NAOC/tree/main/Ti_Gong) and [_Yunlong_Liu's topic1_](https://github.com/guoxiaowhu/GWSC22_NAOC/tree/main/YunLong_Liu/Topic1)
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
Accoring to Soumya D. Mohanty's code, using code [_LISA_animation.m_](https://github.com/guoxiaowhu/GWSC_NAOC/blob/main/GWSIG/LISA_animation.m) we can plot a GIF file to show the orbit of LISA
![LISA orbit](https://raw.githubusercontent.com/guoxiaowhu/GWSC_NAOC/main/figs/LISA_orbitography.gif)
An example of APF of LISA as the function of position (phase Phi) of LISA for two TDI detector tensor I and II under a centrain source location (thet, phi) with code [_testdetframefpfc_psi_LISA.m_](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/topic2/testdetframefpfc_psi_LISA.m)
![LISA_APF](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/figs/APF_LISA.png?raw=true)
For a sine h+ and hx signal, its response is shown as
![LISA_response](https://github.com/guoxiaowhu/GWSC22_NAOC/blob/main/Xiao_Guo/figs/response_LISA.png?raw=true)

## Topic 3 (Noise)
We can see the folder [_NOISE_](https://github.com/guoxiaowhu/GWSC_NAOC/tree/main/NOISE)


## Topic 6 (Application)
With the codes from [He Wang's PSO python demo](https://github.com/iphysresearch/PSO_python_demo),


# References
Some lecture notes can see [this link](https://note.youdao.com/ynoteshare/index.html?id=ad50ed7fa5f67565dce3dfd9b68e0a00&type=note&_time=1644224870530). 
Codes can refer to [Soumya D. Mohanty](https://github.com/mohanty-sd)'s [GWSC](https://github.com/mohanty-sd/GWSC), and [DATASCIENCE_COURSE](https://github.com/mohanty-sd/DATASCIENCE_COURSE). Some codes and materials can also see [GWSC_NAOC](https://github.com/guoxiaowhu/GWSC_NAOC) in last year.
