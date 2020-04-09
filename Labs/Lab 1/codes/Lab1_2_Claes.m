clear all, close all, clc;

s=tf('s');
G=20/((s+1)*((s/20)^2+(s/20)+1));
Gd=10/(1+s);

wI=30;
wc=10;

Fy1=((s+wI)/s)*(Gd/G);

a1=0.001;
b1=sqrt(1-(wc*a1)^2);
a2=0.002;
b2=sqrt(1-(wc*a2)^2);
p1x=a1*s+b1;
p2x=a2*s+b2;

Fy=Fy1/(p1x*p2x)

SGd=Gd/(1+Fy*G);
% step(SGd);

for n=-0.65
T=10^n;

Fr=1/(T*s+1)

% Gr=Fr*G/(1+Fy*G);
% step(Gr);
% stepinfo(Gr);
 
wc=wc; %Desired cross frequency
Pm=-11.15; %Desired phase margin
Px=5.7; %Extra added phase increase due to decrease of phase when lag-component is added


[Gm, Pm1, wp, wc1]=margin(G);
%The phase angle of the initial system G at the desired cross frequency wc
dP=(Pm-Pm1)+Px; %How much phase we want to add to the system, plus a bit extra that will be compensated bby the lag part
B=(-tan(dP*pi/180)+sqrt(((tan(dP*pi/180))^2)+1))^2 %B is decided to make the maximum phase advance equal to dP

tD=1/(wc*sqrt(B)); %tD is determined so that the maximum phase advance happens at w=wc

k=1.8*T;

Fy2=Fy*k*((tD*s+1)/(B*tD*s+1));
 

Gf=Fr*G*Fy2/(1+G*Fy2);
Gfd=Gd/(1+G*Fy2);
u1=Fr/(1+G*Fy2);
u2=-Fy2*Gd/(1+Fy2*G);
% step(Gf)
stepinfo(Gf)
end
step(u1)
hold on
step(u2)
step(u1+u2)