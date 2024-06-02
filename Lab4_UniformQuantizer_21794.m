close all 
clear all
clc
fs = 100;                                % Sample frequency (Hz)
t = 0:1/fs:10-1/fs;                      % 10 sec sample

w=sin(2*pi*t); %max freq is 2 hz

%ws=NaturalSampling(w,fs);
ws=FlatTopSampling(w,fs);

wq=zeros(size(w));
resolution=input('Enter Number of bits :' );
NoLevels=2^resolution -1;

maximum=max(ws);
minimum=maximum;
for i=1:(length(t)/30)-10
    if ws(30*i:5+30*i)<minimum
        minimum=ws(30*i);
    end
end


delta=(maximum-minimum)/(NoLevels);

% for i =1 :(length(t)/30)-10
%     for j=1:2:2*NoLevels
%         if (ws(2+30*i)< minimum+j*(delta/2)) && (ws(2+30*i)> minimum+(j-1)*(delta/2))
%             wq(30*i:30*(i+1))=minimum+(j-1)*(delta/2);
%             
%         elseif (ws(2+30*i)> minimum+j*(delta/2)) && (ws(2+30*i)< minimum+(j+1)*(delta/2))
%             wq(30*i:30*(i+1))=minimum+(j+1)*(delta/2);
%         end
%     end  
% end

for i =1 :(length(t)/30)-10
    for j=minimum:delta:maximum
        if (ws(2+30*i)< j+(delta/2)) && (ws(2+30*i)> j-(delta/2))
            wq(30*i:30*(i+1))=j;
        end
    end  
end
figure(1)
subplot(3,1,1)
plot(w)
subplot(3,1,2)
plot(ws)
subplot(3,1,3)
plot(wq)

figure(2)
plot(w,'k-')
hold on
plot(ws,'b-')
hold on 
plot(wq,'r-')
for i = 0 : NoLevels
    
    level(1:length(t)) = minimum+(delta*i);
    hold on
    plot(level,'y--')
end
