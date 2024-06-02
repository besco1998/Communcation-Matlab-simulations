function ws=NaturalSampling(m,fs)
t = 0:1/fs:10-1/fs;
tauP=zeros(size(m)); %the pulses
for i=1:(length(t)/30)-10
   tauP(30*i:5+30*i) =1;
end
ws=tauP.*m;
end