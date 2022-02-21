**未完待修改**
## 引力波理论用于数据分析

### 学习目标
学习如何计算引力波探测器对平面引力波的响应
- LIGO 和 LISA 响应的计算
- 长波长近似
- 探测器的旋转与运动, 包括LISA

Antenna Patterns: Local frame $\leftarrow$  Analytical forms
辐射方向图
长波长和静态探测器近似贯穿这个实验
- 根据解析公式编写代码，计算L型干涉仪局部坐标系中的$F_y$和$F_x$
1. 源方向: ($\theta,\phi$) 在探测器坐标系中
2. 使用代码画他们到球面坐标系上
3. 演示图

$F_+$ 
![300](Picture/Fplus.jpg)
$F_\times$ 
![300](Picture/Fcross.jpg)

![](Picture/Pasted%20image%2020220221204321.png)
- 通过(a)极化张量, (b)探测器张量 和 (c)极化和探测器张量的缩并获得$F_{+,\times}$ 
- 所有张量分量必须在一个公共坐标系中表示 $\rightarrow$ 在一个公共坐标系中表示所有的单位向量分量
- 我们将使用探测器的坐标系作为公共坐标系
1. 探测器臂单位向量和他们在探测器坐标系中的分量: 
$$
\hat{n}_X=(1,0,0), \quad \hat{n}_X=(0,1,0)
$$
2. 探测器坐标系 $Z$ 向量: $\hat{Z}=(0,0,1)$ ,
3. 源方向向量在探测器坐标系中(极角$\theta$ 和 $\phi$ ): $\hat{n}$
- 波坐标系单位向量分量
在matlab中的描述如下:

```matlab
%Obtain the components of the unit vector pointing to the source location
%获得指向源位置的单位矢量分量 
sinTheta = sin(polAngleTheta(:));
vec2Src = [sinTheta.*cos(polAnglePhi(:)),...
           sinTheta.*sin(polAnglePhi(:)),...
           cos(polAngleTheta(:))];
%Get the wave frame vector components (for multiple sky locations if needed)
%获得波架矢量分量(如果需要，用于多个天空位置?)  
xVec = vcrossprod(repmat([0,0,1],nLocs,1),vec2Src);
yVec = vcrossprod(xVec,vec2Src);
%Normalize wave frame vectors归一化波矢量
for lpl = 1:nLocs
    xVec(lpl,:) = xVec(lpl,:)/norm(xVec(lpl,:));
    yVec(lpl,:) = yVec(lpl,:)/norm(yVec(lpl,:));
end
```


### 应变信号
探测器张量
$$
D = \frac{1}{2} (\hat{n}_X \bigotimes \hat{n}_X - \hat{n}_Y \bigotimes \hat{n}_Y)
$$

``` matlab
%Detector tensor of a perpendicular arm interferometer 
%垂直臂干涉仪的探测器张量  
detTensor = [1,0,0]'*[1,0,0]-[0,1,0]'*[0,1,0];
```

波张量:
$$
\hat{W} = h_+(t) \hat{e}_+ + h_\times(t) \hat{e}_\times 
$$
$$
\hat{e}_+=\hat{x} \bigotimes \hat{x}-\hat{y} \bigotimes \hat{y}; \quad
\hat{e}_\times=\hat{x} \bigotimes \hat{y}+\hat{y} \bigotimes \hat{x}
$$
应变信号: "Contraction of wave and dectector tensiors"
$$
s(t) = \sum_{i,j=1}^3 W_{ij} D_{ij} = W^{ij} D_{ij}= \hat{W}:\hat{D}
$$
注: 使用上述公式时，所有单位矢量分量必须写在同一参照系中
$$
F_+ = \hat{D}:\hat{e}_+; \quad F_\times = \hat{D}:\hat{e}_\times; 
$$


![](Picture/Pasted%20image%2020220210141700.png)
- 对一个不演化双星体系的应变信号
$$
\begin{aligned}
h_+(t)&=A\sin(2 \pi f_0 t)\\
h_+(t)&=B\sin(2 \pi f_0 t +\phi_0)
\end{aligned}
$$
选择自己的$A,B,f_0,\phi_0$值(应用Nyguist定理!)
绘制在不同$\theta$, $\phi$, 和 $\psi$ 下的应变信号
![](Picture/Pasted%20image%2020220221204407.png)



### 静态干涉仪的一般应变信号



![500](Picture/Pasted%20image%2020220210141821.png)




#### Toy LISA 
LISA 玩具模型: 三个卫星组成的刚性等边三角形
- 实际的LISA不可能是刚性的，因为卫星必须遵循开普勒轨道
- LISA玩具模型非常有利于进行数据分析，因为它允许快速生成信号和模板
![500](Picture/LISA_orbitography.gif)





### 相对坐标系和旋转
- 这里共同的相对参考系为太阳系重心参考系(SSB)
- 极化张量(Polarization tensor)将以与探测器坐标系相同的方式计算(见以前的练习)，但现在的坐标系是太阳系重心坐标系(SSB)
- 我们需要在SSB坐标系中找到LISA臂向量的单位分量，然后从臂向量中得到检测器张量
- 最后,缩并探测器张量和极化张量得到天线方向图函数

![](Picture/Pasted%20image%2020220210142113.png)

### 第一步, 获得在SSB坐标系中的SSB分量
1. 在探测器坐标系中,获得旋转臂单位向量分量
2. 获得坐标系变换矩阵(从探测器坐标系到SSB坐标系)
$$
\left(\begin{matrix}  v_1'\\   v_2'\\  v_3' \end{matrix} \right)=
R_{XYZ\rightarrow X'Y'Z'}
\left(\begin{matrix}  v_1\\   v_2\\  v_3 \end{matrix} \right)
$$

$$
R_{XYZ\rightarrow X'Y'Z'}=
\left(\begin{matrix}  
\hat{x}'. \hat{x} & \hat{x}'. \hat{y} & \hat{x}'. \hat{z}\\   
\hat{y}'. \hat{x} & \hat{y}'. \hat{y} & \hat{y}'. \hat{z}\\  
\hat{z}'. \hat{x} & \hat{z}'. \hat{y} & \hat{z}'. \hat{z}
\end{matrix} \right)
$$
其中,
$$
RR^T=1
$$
3. 变换探测器臂单位分量


![](Picture/Pasted%20image%2020220210142352.png)
#### 天线方向图
获得探测器张量 
参考文献[1]
Y. Wang, Y. Shang, and S. Babak, ‘EMRI data analysis with a phenomenological waveform’, _Phys. Rev. D_, vol. 86, no. 10, p. 104050, Nov. 2012, doi: [10.1103/PhysRevD.86.104050](https://doi.org/10.1103/PhysRevD.86.104050).
两个探测器张量分别定义为
$$
D_I =\frac{1}{2} (\hat{n}_1 \bigotimes \hat{n}_1 - \hat{n}_2 \bigotimes \hat{n}_2)
$$
$$
D_{II} =\frac{1}{2\sqrt{3}} (\hat{n}_1 \bigotimes \hat{n}_1 + \hat{n}_2 \bigotimes \hat{n}_2-\hat{n}_3 \bigotimes \hat{n}_3)
$$
其中, $\hat{n}_1$, $\hat{n}_2$, $\hat{n}_3$ 分别代表沿着LISA臂的每一单位向量


![](Picture/Pasted%20image%2020220210143042.png)
天线图信号




![](Picture/Pasted%20image%2020220210143311.png)
### LISA玩具模型响应:部分
编写一个Matlab脚本执行以下操作:
- 生成正弦信号$h_+$, $h_\times$ :脚本应该具有用户指定的天空位置和GW源的偏振角度
- 使用前面练习的代码生成$F_{+,\times}$ 时间序列，生成任何迈克尔逊TDI响应(不包括多普勒频移
$$
s(t)= F_+(t;\theta,\phi) h_+(t)+F_\times(t;\theta,\phi) h_\times(t)
$$
- 取探测器响应的FFT，与$h_+$的FFT进行比较




![](Picture/Pasted%20image%2020220210143459.png)
### LISA玩具模型响应:完整
- LISA探测器响应包括多普勒频移
> $h_{+,\times}(t)\rightarrow h_{+,\times}(t-\frac{\hat{n}.\bar{x}_d}{c})$
>  $\hat{n}$ : 波的传播方向
>  $\bar{x}_d(t)$ : LISA 质心
- 编写一个代码来计算SSB框架中LISA质心（简单圆形轨道）的位置向量$\bar{x}_d$的分量
- 在SSB坐标系中, 对于单色源(monochromatic source), 绘制任何一个的LISA Michelson响应
- 在SSB坐标系中, 对于单色源(monochromatic source), 绘制任何一个的LISA Michelson响应
> 在SSB坐标系中: $h_+(t)=A \sin(\omega_0t)$ ; $h_\times(t)=\frac{A}{2} \cos(\omega_0t)$   
> 生成多普勒频移正弦信号$h_+$, $h_\times$ :
> $$
 h_+(t)=A \sin\left(\omega_0(t-\frac{\hat{n}.\bar{x}_d}{c})\right) ; \quad
 h_\times(t)=B \cos\left(\omega_0(t-\frac{\hat{n}.\bar{x}_d}{c})\right)
 $$
 在这里极化角参数被忽略了
 - 比较FFT

![](Picture/Pasted%20image%2020220210143807.png)
- 取相同的SSB坐标系$h_+$，$h_\times$, 但在不同的天空位置，验证LISA响应是不同的
- 这允许LISA对长期存在的源具有定向灵敏度。


![](Picture/Pasted%20image%2020220210143910.png)

















