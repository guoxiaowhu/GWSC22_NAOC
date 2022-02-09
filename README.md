# GWSC22_NAOC
The repository for a Collaboration for the GWSC in 2022.

# Members
[郭潇（国台）](https://github.com/guoxiaowhu)、[张云龙（国台）](https://github.com/zhangyunlong001)、[赵悦同（国台）](https://github.com/LeonsZhao)、[程功（理论所）](https://github.com/chenggongphy)、牟博（清华）、[郭文渊（华南理工）](https://github.com/ralspi)、孙孟飞（重大）、孙厚义（华科）、刘云龙（华南理工）、朱经亚（河南大学）、郭盼（国科大）、[龚禔（河南大学）](https://github.com/ttigong)、宋仑（华科）、王博锐（重大）、罗智（重大）、李亚玲（南昌大学）、刘雨晨（南昌大学）、张明汇（重大）、何显龙（武大）、袁泳（武大）

# Results
## Topic 1 (Signal Processing)
### Signals
![Signals](https://raw.githubusercontent.com/guoxiaowhu/GWSC22_NAOC/main/Ralspi/topic1/result/signal%20figure.png)
from Wenyuan Guo (ralspi)
### Spectrogram
FFT
![FFT](https://raw.githubusercontent.com/guoxiaowhu/GWSC22_NAOC/main/Ralspi/topic1/result/spectrogram-fft.png)
from Wenyuan Guo (ralspi)

spectrogram
![Spe](https://raw.githubusercontent.com/guoxiaowhu/GWSC22_NAOC/main/Ralspi/topic1/result/spectrogram.png)
from Wenyuan Guo (ralspi)

### Filtering 
With the filter designed by us in [_ThreeSignalsFiltering.m_](https://github.com/guoxiaowhu/GWSC_NAOC/blob/main/DSP/ThreeSignalsFiltering.m), we can filter signals _s_ into three signals:
- s_1: ![s1](https://raw.githubusercontent.com/guoxiaowhu/GWSC_NAOC/main/figs/s1.png)
- s_2: ![s2](https://raw.githubusercontent.com/guoxiaowhu/GWSC_NAOC/main/figs/s2.png)
- s_3: ![s3](https://raw.githubusercontent.com/guoxiaowhu/GWSC_NAOC/main/figs/s3.png)
where red line represents the filtered signals, blue line represents the orginal signal.

You can use _subplot_ to show these three figures.

## Topic 2 (GW Signals)
We can see the folder [_GWSIG_](https://github.com/guoxiaowhu/GWSC_NAOC/tree/main/GWSIG) for previous results
### Antenna Pattern Function (APF)
### Strain
### LISA
Accoring to Soumya D. Mohanty's code, we can plot a GIF file to show the orbit of LISA
![LISA orbit](https://raw.githubusercontent.com/guoxiaowhu/GWSC_NAOC/main/figs/LISA_orbitography.gif)


# References
Some lecture notes can see [this link](https://note.youdao.com/ynoteshare/index.html?id=ad50ed7fa5f67565dce3dfd9b68e0a00&type=note&_time=1644224870530). 
Codes can refer to [Soumya D. Mohanty](https://github.com/mohanty-sd)'s [GWSC](https://github.com/mohanty-sd/GWSC), and [DATASCIENCE_COURSE](https://github.com/mohanty-sd/DATASCIENCE_COURSE). Some codes and materials can also see [GWSC_NAOC](https://github.com/guoxiaowhu/GWSC_NAOC) (especially the [*task*](https://github.com/guoxiaowhu/GWSC_NAOC/tree/main/task) folder) in last year.
