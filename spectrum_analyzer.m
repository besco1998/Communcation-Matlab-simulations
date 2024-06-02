%spectrum analyzer
carrier_freq=1000;
msg_freq = 100;
t= 0:0.0001:1;
carrier=cos(2*pi*carrier_freq*t);
msg=cos(2*pi*msg_freq*t);

AM_out=carrier+carrier.*msg;

FM_out=cos((2*pi*carrier_freq*t).*msg);

f= -(length(AM_out)-1)/2:1:(length(AM_out)-1)/2;
tr=abs(fftshift(fft(AM_out)));
plot(f,tr)