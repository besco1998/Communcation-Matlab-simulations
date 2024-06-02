close all 
clear all
clc
fs = 100;                                % Sample frequency (Hz)
t = 0:1/fs:10-1/fs;                      % 10 sec sample

w=5+sin(2*pi*t)+cos(2*pi*2*t); %max freq is 2 hz
tauP=zeros(size(w)); %the pulses
ws=zeros(size(w));

for i=1:(length(t)/30)-10
   ws(30*i:5+30*i)=w(30*i);
   tauP(30*i:5+30*i) =1;
end

%signal spectrum
wlength = length(w);          % Window length
f = (-wlength/2:wlength/2-1)*(fs/wlength);  % 0-centered frequency range
FW = fftshift(fft(w));          % Rearrange y values
powerW = abs(FW)/wlength;   % 0-centered power
%pulse spectrum
FtauP = fftshift(fft(tauP));          % Rearrange y values
powertauP = abs(FtauP)/wlength;   % 0-centered power
%sampled signal spectrum
Fws = fftshift(fft(ws));          % Rearrange y values
powerws = abs(Fws)/wlength;   % 0-centered power

figure(1)
subplot(3,1,1)
plot(t,w)
title('FlatTop Sampling')
xlabel('Time [sec]')
ylabel('Signal')
subplot(3,1,2)
plot(t,tauP)
xlabel('Time [sec]')
ylabel('pulses')
subplot(3,1,3)
plot(t,ws)
xlabel('Time [sec]')
ylabel('Sampled Signal')

figure(2)
subplot(3,1,1)
plot(f,powerW)
title('FlatTop Sampling spectrum')
xlabel('Freq [Hz]')
ylabel('Signal spectrum')
subplot(3,1,2)
plot(f,powertauP)
xlabel('Freq [Hz]')
ylabel('pulses spectrum')
subplot(3,1,3)
plot(f,powerws)
xlabel('Freq [Hz]')
ylabel('Sampled Signal spectrum')