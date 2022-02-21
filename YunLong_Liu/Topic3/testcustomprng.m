%% 
%1. Uses customrand and customrandn functions to generate 10,000 trials values 
%2. Make normalized histograms for each case
%3. On top of each histogram, plot the respective PDFs above
%4. Submit the codes and the plots
N=1;
M=10000;
%% Uniform PDF U(x;0,1)
U=rand(N,M);

%% Standrad PDFs N(x;0,1)
S=randn(N,M);

%histogram(U,'normalization','pdf')
%figure
%histogram(S,'normalization','pdf')

a=-2;
b=1;
x=linspace(-3,2,100);
U=(a<x&x<b).*1/(b-a)+(x>a|x<b).*0;


Uab=customrand(N,M,a,b);
Fig1=figure;
histogram(Uab,'normalization','pdf');hold on
plot(x,U,'r');
xlabel('x');
ylabel('Amplitude');
saveas(Fig1,'FIGcustomrand.jpg');

a=1;
b=0;
x=linspace(-5,10,100);
U=1/(a*sqrt(2*pi)).*exp(-(x-b).^2./(a^2*2));

Nab=customrandn(N,M,a,b);
Fig2=figure;
histogram(Nab,'normalization','pdf');hold on 
plot(x,U,'r');
xlabel('x');
ylabel('Amplitude');
saveas(Fig2,'FIGcustomrandn.jpg');

