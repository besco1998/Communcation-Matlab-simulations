N=10^3; % number of bits to generate

SNR_dB=[-5:5:25]; %step 5
SNR_ratio=10.^(SNR_dB/10);
k=1./sqrt(SNR_ratio);

for ii=1:length(SNR_dB)
Mydata=randi([0 1],1,N);

q=1;
for jj=1:2:length(Mydata)
    if ((Mydata(jj)==0) && (Mydata(jj+1)==0))
        MyDataMod(q)=-1+i;
    elseif ((Mydata(jj)==0) && (Mydata(jj+1)==1))
        MyDataMod(q)=-1-i;
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==0))
        MyDataMod(q)=1+i; 
    elseif ((Mydata(jj)==1) && (Mydata(jj+1)==1))
        MyDataMod(q)=1-i; 
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
    if (sign(real(MyRxSig(jj)))==-1)&&(sign(imag(MyRxSig(jj)))==1)
        MyRx_data(p)=0;
        MyRx_data(p+1)=0;
    elseif (sign(real(MyRxSig(jj)))==-1)&&(sign(imag(MyRxSig(jj)))==-1)
        MyRx_data(p)=0; 
        MyRx_data(p+1)=1;
        
        elseif (sign(real(MyRxSig(jj)))==1)&&(sign(imag(MyRxSig(jj)))==1)
        MyRx_data(p)=1; 
        MyRx_data(p+1)=0;
        
    elseif (sign(real(MyRxSig(jj)))==1)&&(sign(imag(MyRxSig(jj)))==-1)
        MyRx_data(p)=1; 
        MyRx_data(p+1)=1;
    end
    p=p+2;
end
Number_of_errors=sum(abs(MyRx_data-Mydata)/2)
MyBER(ii)=Number_of_errors/N;
end

semilogy(SNR_dB,MyBER)
scatterplot (MyRxSig)
grid on