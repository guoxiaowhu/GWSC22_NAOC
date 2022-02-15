clear
close all
A=1;
Coefs=[20,0];
TimeVec=0:0.001:1;
Signal=gensigvec(TimeVec,A,Coefs,1);
plot(TimeVec,Signal);

A=1;
Coefs=[1,20,0];
TimeVec=0:0.001:1;
Signal=gensigvec(TimeVec,A,Coefs,2);
plot(TimeVec,Signal);

A=1;
Coefs=[0.5,0.1,100,0];
TimeVec=0:0.001:1;
Signal=gensigvec(TimeVec,A,Coefs,3);
plot(TimeVec,Signal);

A=1;
Coefs=[10,20,1];
TimeVec=0:0.001:4;
Signal=gensigvec(TimeVec,A,Coefs,4);
plot(TimeVec,Signal);

A=1;
Coefs=[20,1,0];
TimeVec=0:0.001:4;
Signal=gensigvec(TimeVec,A,Coefs,5);
plot(TimeVec,Signal);

A=1;
Coefs=[10,20,1];
TimeVec=0:0.001:4;
Signal=gensigvec(TimeVec,A,Coefs,6);
plot(TimeVec,Signal);

A=1;
Coefs=[-1,1,5,0,2];
TimeVec=-2:0.001:2;
Signal=gensigvec(TimeVec,A,Coefs,7);
plot(TimeVec,Signal);

A=1;
Coefs=[-1,10,1,0,2];
TimeVec=-2:0.001:2;
Signal=gensigvec(TimeVec,A,Coefs,8);
plot(TimeVec,Signal);

A=1;
Coefs=[0,1,10];
TimeVec=-2:0.001:2;
Signal=gensigvec(TimeVec,A,Coefs,9);
plot(TimeVec,Signal);