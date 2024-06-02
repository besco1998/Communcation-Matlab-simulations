
clear all
close all
clc

%finite dipole

lambda=1;
l=5*lambda;

i=1;j=1;
step=50;
for theta=0:pi/step:pi
    for phi=0:pi/step:2*pi
        r=sin(theta)^2;
        x(i,j)=r*sin(theta)*cos(phi);
        y(i,j)=r*sin(theta)*sin(phi);
        z(i,j)=r*cos(theta);
        j=j+1;
    end
    j=1;
    i=i+1;
end
figure
mesh(x,y,z)
title('Infinitizmal Dipole Radiation Pattern')
xlabel('x')
ylabel('y')
zlabel('z')
hidden off 
