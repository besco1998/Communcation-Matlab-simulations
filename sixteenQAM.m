N=4*10^5 ;                                                              ; % number of bits to generate
amplitude=4;
SNR_dB=[0:25]; %step 5
SNR_ratio=10.^(SNR_dB/10);
k=1./sqrt(SNR_ratio);
%MyRx_data=[1:N];
for ii=1:length(SNR_dB)
Mydata=randi([0 1],1,N);

q=1;
for jj=1:4:length(Mydata)
    if ((Mydata(jj)==0) && (Mydata(jj+1)==0)&& (Mydata(jj+2)==0) && (Mydata(jj+3)==0))      %0
        MyDataMod(q)=-(3/4*amplitude)+(3/4*amplitude)*i;
    elseif ((Mydata(jj)==0) && (Mydata(jj+1)==0)&& (Mydata(jj+2)==0) && (Mydata(jj+3)==1))   %1
        MyDataMod(q)=-(3/4*amplitude)+(1/4*amplitude)*i;
    elseif ((Mydata(jj)==0) && (Mydata(jj+1)==0)&& (Mydata(jj+2)==1)&& (Mydata(jj+3)==0))   %2
        MyDataMod(q)=-(3/4*amplitude)-(1/4*amplitude)*i; 
    elseif ((Mydata(jj)==0) && (Mydata(jj+1)==0)&& (Mydata(jj+2)==1)&& (Mydata(jj+3)==1))   %3
        MyDataMod(q)=-(3/4*amplitude)-(3/4*amplitude)*i;
    elseif ((Mydata(jj)==0) && (Mydata(jj+1)==1)&& (Mydata(jj+2)==0)&& (Mydata(jj+3)==0))   %4
        MyDataMod(q)=-(1/4*amplitude)+(3/4*amplitude)*i;
    elseif ((Mydata(jj)==0) && (Mydata(jj+1)==1)&& (Mydata(jj+2)==0)&& (Mydata(jj+3)==1))   %5
        MyDataMod(q)=-(1/4*amplitude)+(1/4*amplitude)*i;
    elseif ((Mydata(jj)==0) && (Mydata(jj+1)==1)&& (Mydata(jj+2)==1)&& (Mydata(jj+3)==0))   %6
        MyDataMod(q)=-(1/4*amplitude)-(1/4*amplitude)*i;
    elseif ((Mydata(jj)==0) && (Mydata(jj+1)==1)&& (Mydata(jj+2)==1)&& (Mydata(jj+3)==1))   %7
        MyDataMod(q)=-(1/4*amplitude)-(3/4*amplitude)*i; 
     
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==0)&& (Mydata(jj+2)==0) && (Mydata(jj+3)==0))      %8
        MyDataMod(q)=(1/4*amplitude)+(3/4*amplitude)*i;
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==0)&& (Mydata(jj+2)==0) && (Mydata(jj+3)==1))   %9
        MyDataMod(q)=(1/4*amplitude)+(1/4*amplitude)*i;
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==0)&& (Mydata(jj+2)==1)&& (Mydata(jj+3)==0))   %10
        MyDataMod(q)=(1/4*amplitude)-(1/4*amplitude)*i; 
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==0)&& (Mydata(jj+2)==1)&& (Mydata(jj+3)==1))   %11
        MyDataMod(q)=(1/4*amplitude)-(3/4*amplitude)*i;
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==1)&& (Mydata(jj+2)==0)&& (Mydata(jj+3)==0))   %12
        MyDataMod(q)=(3/4*amplitude)+(3/4*amplitude)*i;
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==1)&& (Mydata(jj+2)==0)&& (Mydata(jj+3)==1))   %13
        MyDataMod(q)=(3/4*amplitude)+(1/4*amplitude)*i;
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==1)&& (Mydata(jj+2)==1)&& (Mydata(jj+3)==0))   %14
        MyDataMod(q)=(3/4*amplitude)-(1/4*amplitude)*i;
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==1)&& (Mydata(jj+2)==1)&& (Mydata(jj+3)==1))   %15
        MyDataMod(q)=(3/4*amplitude)-(3/4*amplitude)*i;         
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
    if (imag(MyRxSig(jj))>2 && imag(MyRxSig(jj))<4 && real(MyRxSig(jj))>-4 && real(MyRxSig(jj))<-2 )        %0
        MyRx_data(p)=0;
        MyRx_data(p+1)=0;
        MyRx_data(p+2)=0;
        MyRx_data(p+3)=0;
    elseif (imag(MyRxSig(jj))>0 && imag(MyRxSig(jj))<2 && real(MyRxSig(jj))>-4 && real(MyRxSig(jj))<-2 )    %1
        MyRx_data(p)=0;
        MyRx_data(p+1)=0;
        MyRx_data(p+2)=0;
        MyRx_data(p+3)=1;
    elseif (imag(MyRxSig(jj))>-2 && imag(MyRxSig(jj))<0 && real(MyRxSig(jj))>-4 && real(MyRxSig(jj))<-2 )    %2
        MyRx_data(p)=0;
        MyRx_data(p+1)=0;
        MyRx_data(p+2)=1;
        MyRx_data(p+3)=0;
    elseif (imag(MyRxSig(jj))>-4 && imag(MyRxSig(jj))<-2 && real(MyRxSig(jj))>-4 && real(MyRxSig(jj))<-2 )    %3
        MyRx_data(p)=0;
        MyRx_data(p+1)=0;
        MyRx_data(p+2)=1;
        MyRx_data(p+3)=1;
    elseif (imag(MyRxSig(jj))>2 && imag(MyRxSig(jj))<4 && real(MyRxSig(jj))>-2 && real(MyRxSig(jj))<0 )    %4
        MyRx_data(p)=0;
        MyRx_data(p+1)=1;
        MyRx_data(p+2)=0;
        MyRx_data(p+3)=0;
    elseif (imag(MyRxSig(jj))>0 && imag(MyRxSig(jj))<2 && real(MyRxSig(jj))>-2 && real(MyRxSig(jj))<0 )    %5
        MyRx_data(p)=0;
        MyRx_data(p+1)=1;
        MyRx_data(p+2)=0;
        MyRx_data(p+3)=1;
    elseif (imag(MyRxSig(jj))>-2 && imag(MyRxSig(jj))<0 && real(MyRxSig(jj))>-2 && real(MyRxSig(jj))<0 )    %6
        MyRx_data(p)=0;
        MyRx_data(p+1)=1;
        MyRx_data(p+2)=1;
        MyRx_data(p+3)=0; 
    elseif (imag(MyRxSig(jj))>-4 && imag(MyRxSig(jj))<-2 && real(MyRxSig(jj))>-2 && real(MyRxSig(jj))<0 )    %7
        MyRx_data(p)=0;
        MyRx_data(p+1)=1;
        MyRx_data(p+2)=1;
        MyRx_data(p+3)=1; 

        
    elseif (imag(MyRxSig(jj))>2 && imag(MyRxSig(jj))<4 && real(MyRxSig(jj))>0 && real(MyRxSig(jj))<2 )        %8
        MyRx_data(p)=1;
        MyRx_data(p+1)=0;
        MyRx_data(p+2)=0;
        MyRx_data(p+3)=0;
    elseif (imag(MyRxSig(jj))>0 && imag(MyRxSig(jj))<2 && real(MyRxSig(jj))>0 && real(MyRxSig(jj))<2 )    %9
        MyRx_data(p)=1;
        MyRx_data(p+1)=0;
        MyRx_data(p+2)=0;
        MyRx_data(p+3)=1;
    elseif (imag(MyRxSig(jj))>-2 && imag(MyRxSig(jj))<0 && real(MyRxSig(jj))>0 && real(MyRxSig(jj))<2 )    %10
        MyRx_data(p)=1;
        MyRx_data(p+1)=0;
        MyRx_data(p+2)=1;
        MyRx_data(p+3)=0;
    elseif (imag(MyRxSig(jj))>-4 && imag(MyRxSig(jj))<-2 && real(MyRxSig(jj))>0 && real(MyRxSig(jj))<2 )    %11
        MyRx_data(p)=1;
        MyRx_data(p+1)=0;
        MyRx_data(p+2)=1;
        MyRx_data(p+3)=1;
    elseif (imag(MyRxSig(jj))>2 && imag(MyRxSig(jj))<4 && real(MyRxSig(jj))>2 && real(MyRxSig(jj))<4 )    %12
        MyRx_data(p)=1;
        MyRx_data(p+1)=1;
        MyRx_data(p+2)=0;
        MyRx_data(p+3)=0;
    elseif (imag(MyRxSig(jj))>0 && imag(MyRxSig(jj))<2 && real(MyRxSig(jj))>2 && real(MyRxSig(jj))<4 )    %13
        MyRx_data(p)=1;
        MyRx_data(p+1)=1;
        MyRx_data(p+2)=0;
        MyRx_data(p+3)=1;
    elseif (imag(MyRxSig(jj))>-2 && imag(MyRxSig(jj))<0 && real(MyRxSig(jj))>2 && real(MyRxSig(jj))<4 )    %14
        MyRx_data(p)=1;
        MyRx_data(p+1)=1;
        MyRx_data(p+2)=1;
        MyRx_data(p+3)=0; 
    elseif (imag(MyRxSig(jj))>-4 && imag(MyRxSig(jj))<-2 && real(MyRxSig(jj))>2 && real(MyRxSig(jj))<4 )    %15
        MyRx_data(p)=1;
        MyRx_data(p+1)=1;
        MyRx_data(p+2)=1;
        MyRx_data(p+3)=1;         
    end
    p=p+4;
end

Number_of_errors=sum(abs(MyRx_data-Mydata))
MyBER(ii)=Number_of_errors/N;
end

semilogy(SNR_dB,MyBER)
scatterplot (MyRxSig)
grid on