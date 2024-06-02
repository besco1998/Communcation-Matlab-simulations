N=3000; % number of bits to generate

SNR_dB=[-5:5:25]; %step 5
SNR_ratio=10.^(SNR_dB/10);
k=1./sqrt(SNR_ratio);

for ii=1:length(SNR_dB)
Mydata=randi([0 1],1,N);

q=1;
for jj=1:3:length(Mydata)
    if ((Mydata(jj)==0) && (Mydata(jj+1)==0)&& (Mydata(jj+2)==0))       %0
        MyDataMod(q)=exp(i*pi/8);
    elseif ((Mydata(jj)==0) && (Mydata(jj+1)==0)&& (Mydata(jj+2)==1))   %1
        MyDataMod(q)=exp(i*3*pi/8);
    elseif ((Mydata(jj)==0) && (Mydata(jj+1)==1)&& (Mydata(jj+2)==0))   %2
        MyDataMod(q)=exp(i*5*pi/8); 
    elseif ((Mydata(jj)==0) && (Mydata(jj+1)==1)&& (Mydata(jj+2)==1))   %3
        MyDataMod(q)=exp(i*7*pi/8);
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==0)&& (Mydata(jj+2)==0))   %4
        MyDataMod(q)=exp(i*9*pi/8);
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==0)&& (Mydata(jj+2)==1))   %5
        MyDataMod(q)=exp(i*11*pi/8);
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==1)&& (Mydata(jj+2)==0))   %6
        MyDataMod(q)=exp(i*13*pi/8);
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==1)&& (Mydata(jj+2)==1))   %7
        MyDataMod(q)=exp(i*15*pi/8);        
    end
    q=q+1;
end

Mynoise=(k(ii)*randn(size(MyDataMod))+i*k(ii)*randn(size(MyDataMod)))/sqrt(2);
%Power_noise=sum(Mynoise.^2)/N;
%Should_be=k(ii)*k(ii);
%%% Mix signal and noise to get the received signal
MyRxSig=MyDataMod+Mynoise;

p=1;

%%% Here is the receiver\
for jj=1:length(MyRxSig)
    if (angle(MyRxSig(jj))>0)&&(angle(MyRxSig(jj))< pi/4)
        MyRx_data(p)=0;
        MyRx_data(p+1)=0;
        MyRx_data(p+2)=0;
    elseif (angle(MyRxSig(jj))>pi/4)&&(angle(MyRxSig(jj))< pi/2)
        MyRx_data(p)=0; 
        MyRx_data(p+1)=0;
        MyRx_data(p+2)=1;
        elseif (angle(MyRxSig(jj))>pi/2)&&(angle(MyRxSig(jj))< 3*pi/4)
        MyRx_data(p)=0; 
        MyRx_data(p+1)=1;
        MyRx_data(p+2)=0;
    elseif (angle(MyRxSig(jj))>3*pi/4)&&(angle(MyRxSig(jj))<pi)
        MyRx_data(p)=0; 
        MyRx_data(p+1)=1;
        MyRx_data(p+2)=1;
    elseif (angle(MyRxSig(jj))<0)&&(angle(MyRxSig(jj))> -pi/4)
        MyRx_data(p)=1; 
        MyRx_data(p+1)=1;
        MyRx_data(p+2)=1;
        elseif (angle(MyRxSig(jj))<-pi/4)&&(angle(MyRxSig(jj))> -pi/2)
        MyRx_data(p)=1; 
        MyRx_data(p+1)=1;
        MyRx_data(p+2)=0;
    elseif (angle(MyRxSig(jj))<-pi/2)&&(angle(MyRxSig(jj))> -3*pi/4)
        MyRx_data(p)=1; 
        MyRx_data(p+1)=0;
        MyRx_data(p+2)=1;   
    elseif (angle(MyRxSig(jj))<-3*pi/4)&&(angle(MyRxSig(jj))> -pi)
        MyRx_data(p)=1; 
        MyRx_data(p+1)=0;
        MyRx_data(p+2)=0;        
    end
    p=p+3;
end
Number_of_errors=sum(abs(MyRx_data-Mydata))
MyBER(ii)=Number_of_errors/N;
end

semilogy(SNR_dB,MyBER)
scatterplot (MyRxSig)
grid on