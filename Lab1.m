clear all, close all, clc;

wc=0.4; %Desired cross frequency
Pm=30; %Desired phase margin
Px=5.7; %Extra added phase increase due to decrease of phase when lag-component is added

s=tf('s');
G=(3*(-s+1))/((5*s+1)*(10*s+1));

Gf=@(x) ((3*(-x+1))/((5*x+1)*(10*x+1)));
Pm1=angle(Gf(wc*i))*180/pi+180; %The phase angle of the initial system G at the desired cross frequency wc
dP=(Pm-Pm1)+Px; %How much phase we want to add to the system, plus a bit extra that will be compensated bby the lag part
B=(-tan(dP*pi/180)+sqrt(((tan(dP*pi/180))^2)+1))^2 %B is decided to make the maximum phase advance equal to dP

tD=1/(wc*sqrt(B)) %tD is determined so that the maximum phase advance happens at w=wc

K=1/(abs(Gf(wc*i)*((tD*wc*i+1)/(tD*B*wc*i+1)))) %Set to make abs(K*lead*G(jwc))=1

g=0 %Set to make the stationary error zero

tI=10/wc %Set to make the decrease in phase be 5,7 degrees, that is the same as the extra phase increase that was added in the lead part

F=K*((tD*s+1)/(tD*B*s+1))*((tI*s+1)/(tI*s+g)); %The total controller
[Gm, Pm, wp, wc]=margin(F*G);
Pm
wc

%The closed loop system T=FG/(1+FG) is defined as a function Tf(x) in order
%to determine the bandwidth and resonance peak:
Tf=@(x) (K*((tD*x+1)/(tD*B*x+1))*((tI*x+1)/(tI*x+g)))*((3*(-x+1))/((5*x+1)*(10*x+1)))/((K*((tD*x+1)/(tD*B*x+1))*((tI*x+1)/(tI*x+g)))*((3*(-x+1))/((5*x+1)*(10*x+1)))+1);

%Bandwidth test:
w=0.001;
while abs(Tf(w*i))>1/sqrt(2) %The frequency is increased until the magnitude is less than 1/sqrt(2)
    w=w+0.001;
end
bw=w;
bw %The bandwidth

%Resonance peak test:
w1=0.187;
w2=0.188; %A slight magnitude decrease happens in the beginning, hence why we can't start at very small w1 and w2
dw=0.0001;
while abs(Tf(w2*i))>abs(Tf(w1*i)) %The frequency is increased until Tf(x*i) starts to decrease
    w2=w2+dw;
    w1=w1+dw;
end
MT=abs(Tf(w1*i));
MT %The resonance peak

T=G*F/(1+G*F); %The closed loop system transfer function
s=stepinfo(T); %Gives among other things the overshoot and rise time
s