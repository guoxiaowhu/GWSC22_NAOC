function sig=gensi9(dataX,magni,para,mode1)
% Generate a signal
% OUTPUT=GENQCSI9(INPUT,MAGNITITUDE,PARAMETER)
% input is the interval of the target signal
% magnititude is the maximum of the signal
% output is the target signal
% ralspi, Feburary 2022
    if mode1==1
        % Generate the sinusoidal signal
        % parameter is the phase of signal in parametric way: [a1 a2 ~ ~ ~]
        % the phase of signal is: 2*pi*a1*t+a2

        phi=para(1);
        sig=sin(2*pi*phi.*dataX+para(2));
        sig=magni*sig./norm(sig);
    end
    if mode1==2
        % Generate the linear chirp signal
        % parameter is the phase of signal in parametric way: [a1 a2 a3 ~ ~]
        % the phase of signal is: 2*pi*(a1+a2*t)*t+a3
        phi=para(1)+para(2)*dataX;
        sig=sin(2*pi*phi.*dataX+para(3));
        sig=magni*sig./norm(sig);
    end
    if mode1==3
        % Generate the sine-gaussian signal
        % parameter is the phase of signal in parametric way: [a1 a2 a3 a4 ~]
        % the whole function is: manititude*exp(-0.5*((t-a1)/a2)^2) * sin(2*pi*a3+a4)
        phi=para(3);
        sig=exp(-0.5*((dataX-para(1))./para(2)).*((dataX-para(1))./para(2))).*sin(2*pi*phi.*dataX+para(4));
        sig=magni*sig./norm(sig);
    end
    if mode1==4
        % Generate the FM sinusoid
        % parameter is the phase of signal in parametric way: [a1 a2 a3 ~ ~]
        % the phase of signal is: 2*pi*a2*t+a1*cos(2*pi*a3*t)
        phi=para(2);
        sig=sin(2*pi*phi.*dataX+para(1).*cos(2*pi*para(2).*dataX));
        sig=magni*sig./norm(sig);
    end
    if mode1==5
        % Generate the AM sinusoid
        % parameter is the phase of signal in parametric way: [a1 a2 a3 ~ ~]
        % the whole function is: magnititude*cos(2*pi*a1*t)*sin(2*pi*a1*t+a3)
        phi=para(1);
        sig=sin(2*pi*phi.*dataX+para(3)).*cos(2*pi*para(2).*dataX);
        sig=magni*sig./norm(sig);
    end
    if mode1==6
        % Generate the AM-FM sinusoid
        % parameter is the phase of signal in parametric way: [a1 a2 a3 ~ ~]
        % the whole function is: magnititude*cos(2*pi*a3*t)*sin(2*pi*a2*t+a1*cos(2*pi*a3*t))
        phi=para(2);
        sig=sin(2*pi*phi.*dataX+para(1)*cos(2*pi*para(3).*dataX)).*cos(2*pi*para(3).*dataX);
        sig=magni*sig./norm(sig);
    end
    if mode1==7
        % Generate the time-shift signal
        % parameter is the phase of signal in parametric way: [a1 a2 a3 a4 a5]
        % the whole function is: 
        % when t belongs to [a1,a1+a5]   the phase of the signal is:2*pi*(a2*(t-a1)+a3*(t-a1)^2)+a4
        % when t is not in [a1,a1+a5]   the phase of the signal is:0
        for i=1:length(dataX)
            if dataX(i)>=para(1)&&dataX(i)<=(para(1)+para(end))
                phi=para(2)*(dataX(i)-para(1))+para(3)*(dataX(i)-para(1))^2;
                sig(i)=sin(2*pi*phi+para(4));
                %sig(i)=1;
            else
                sig(i)=0;
            end
        end
        sig=magni*sig./norm(sig);
    end 
    if mode1==8
        % Generate a quadratic chirp signal
        % parameter is the phase of signal in parametric way: [a1 a2 a3 ~ ~]
        % the phase of signal is: 2*pi*(a1*t+a2*t^2+a3*t^3)*t

        phi=para(1)+para(2)*dataX+para(3)*dataX.*dataX;
        sig=sin(2*pi*phi.*dataX);
        sig=magni*sig./norm(sig);
    end