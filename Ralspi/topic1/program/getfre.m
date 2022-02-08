function f1=getfre(dataX,sig)
% calculate the frequency of a signal
% OUTPUT=GETFRE(X,SIGNAL)
% X is the timeline of the signal,signal is the signal
% output is the target frequency
% ralspi, Feburary 2022

phi=asin(sig)./2/pi;
for i=1:length(dataX)-1
    f1(i)=(phi(i+1)-phi(i))/(dataX(i+1)-dataX(i));
end
f1=abs(f1);