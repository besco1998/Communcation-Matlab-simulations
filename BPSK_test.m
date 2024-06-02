N=1*10^6;
%generate data
MyData=(2*randi([0 1],1,N))-1;

%generate noise
MyNoise=randn(1,N);

MyRxSignal=MyData+MyNoise;
MyDetector=sign(MyRxSignal);

hist(MyNoise,100)