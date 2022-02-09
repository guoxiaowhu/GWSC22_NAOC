
## 任务1
### 信号产生
#### AMFM信号
这次任务中我们选择了AMFM信号:
$$
s(t) = A \cos(2 \pi f_2 t) \sin(2 \pi f_0 t + b \cos(2 \pi f_1 t))
$$
信号波形, 如下:
![400](Picture/Sig.jpg)
通过快速傅里叶变换
![400](Picture/FftAMFMSig.jpg)

![400](Picture/TFAMFMSig.jpg)

#### Sine-Guassian signal 
$$
s(t) = A \cos(2 \pi f_2 t) \sin(2 \pi f_0 t + b \cos(2 \pi f_1 t))
$$
![400](Picture/Sine_Gassian_sig.jpg)
快速傅里叶变换后的结果
![400](Picture/FftSiGaSig.jpg)
![400](Picture/TFSiGaSig.jpg)

####  Step FM
$$
s(t) = 
\begin{cases}
A \sin(2 \pi f_0t) & if: t \leq t_a\\
A \sin(2 \pi f_1 (t-t_a)+2 \pi f_0 t_a) & if: t > t_a
\end{cases}
$$

![500](Picture/StepFM_sig.jpg)

![500](Picture/StepFMSig.jpg)

![500](Picture/TFStFMSig.jpg)



## 滤波
### 信号源
$$
s(t)= \sin(2 \pi f_1 t + \phi_1) + \sin(2 \pi f_2 t + \phi_2)+
    sin(2 \pi f_2 t + \phi_2);
$$

### 低通滤波器的设计
![500](Picture/LowpassDesign.jpg)

![500](Picture/LowpassfftSig.jpg)

![500](Picture/LowpassSig.jpg)
### 带通滤波器的设计
带通
![500](Picture/BandpassDesign.jpg)

![500](Picture/BandpassfftSig.jpg)

![500](Picture/BandpassSig.jpg)

### 高通滤波器的设计
![500](Picture/HighpassDesign.jpg)

![500](Picture/HighpassfftSig.jpg)

![500](Picture/HighpassSig.jpg)
