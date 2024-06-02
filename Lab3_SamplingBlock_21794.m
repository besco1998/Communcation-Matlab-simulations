% close all 
% clear all
% clc

samplingType=input('select(0->Natural sampling)(1->FlatTop sampling)\n sampling type = ');% Sample type 0 for NaturalSampling 1 for FlatTopSampling
messageType=input('select(0->Sinusodial Wave)(1->Sawtooth Wave)(2->Rectangle Wave)\n message type = ');% Message type 0 for sinusodial signal
                                         % 1 for sawtooth signal 
                                         % 2 for rectangular signal 
                                    
fs = input('Sampling Frequency [Hz] = ');% Sample frequency (Hz)
t = 0:1/fs:10-1/fs;                      % 10 sec sample

fm=input('Message Frequency [Hz] = ');                                    % message Frequency  (Hz)


if (fs < 2*fm)
    disp('Sampling Freq is less than double message Freq !')
    disp('Sampling Freq is now double message Freq !')
    fs=2*fm;
end
                                 

if (messageType == 0)
    m = sin(2*pi*fm*t);
elseif (messageType == 1)
    m = sawtooth(2*pi*fm*t);
elseif (messageType == 2)
    duty=input('Duty Cycle [0->100] = ');                               % duty cycle for square wave
    m = square(2*pi*fm*t,duty);
end


tauP=zeros(size(m)); %the pulses
ws=zeros(size(m));

if (samplingType==0)
    for i=1:(length(t)/30)-10
        tauP(30*i:5+30*i) =1;
    end
    ws=tauP.*m;
    mlength = length(m);          % Window length
    f = (-mlength/2:mlength/2-1)*(fs/mlength);  % 0-centered frequency range
    FW = fftshift(fft(m));          % Rearrange y values
    powerW = abs(FW)/mlength;   % 0-centered power
    %pulse spectrum
    FtauP = fftshift(fft(tauP));          % Rearrange y values
    powertauP = abs(FtauP)/mlength;   % 0-centered power
    %sampled signal spectrum
    Fws = fftshift(fft(ws));          % Rearrange y values
    powerws = abs(Fws)/mlength;   % 0-centered power

    figure(1)
    subplot(3,1,1)
    plot(t,m)
    title('Natural Sampling')
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
    title('Natural Sampling spectrum')
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
    
elseif(samplingType==1)
    for i=1:(length(t)/30)-10
        ws(30*i:5+30*i)=m(30*i);
        tauP(30*i:5+30*i) =1;
    end

    %signal spectrum
    mlength = length(m);          % Window length
    f = (-mlength/2:mlength/2-1)*(fs/mlength);  % 0-centered frequency range
    FW = fftshift(fft(m));          % Rearrange y values
    powerW = abs(FW)/mlength;   % 0-centered power
    %pulse spectrum
    FtauP = fftshift(fft(tauP));          % Rearrange y values
    powertauP = abs(FtauP)/mlength;   % 0-centered power
    %sampled signal spectrum
    Fws = fftshift(fft(ws));          % Rearrange y values
    powerws = abs(Fws)/mlength;   % 0-centered power

    figure(1)
    subplot(3,1,1)
    plot(t,m)
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
end

