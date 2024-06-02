%osciliscope
%AM Modulation 
carrier_freq=1000;
msg_freq = 10;
t= 0:0.000001:0.1;

carrier=cos(2*pi*carrier_freq*t);
msg=cos(2*pi*msg_freq*t);

AM_out=carrier.*msg;
FM_out=cos(2*pi*carrier_freq*t.*msg);

plot(t,AM_out)