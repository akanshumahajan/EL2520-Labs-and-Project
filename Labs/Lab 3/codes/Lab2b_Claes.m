clear all, close all, clc

s=tf('s');

sysmp=nonminphase;

A=[-0.05106, 0, 0.08582, 0; 0, -0.04692, 0, 0.09089; 0, 0, -0.08582, 0; 0, 0, 0, -0.09089];
B=[0.1044, 0; 0, 0.09038; 0, 01506; 0.174, 0];
C=[0.2, 0, 0, 0; 0, 0.2, 0, 0];
D=[0, 0; 0, 0];

G=C*((s*eye(4)-A)^-1)*B+D;

Gf=@(w) [0.02088/(w+0.05106), 0.003163/(w^2+0.01378*w+0.004265); 25.85/(w^2+0.1369*w+0.004382), 0.01808/(w+0.04692)];

%%

Pm=pi/3;
wc=0.03;

Gwc=Gf(1i*wc);
T1=(((tan((-pi/2)+Pm-angle(Gwc(1,1)))))/wc);

l_11_wc=Gwc(1,1)*(1+(1/(1i*wc*T1)));
K1=1/(abs(l_11_wc));

T2=((tan((-pi/2)+Pm-angle(Gwc(2,2))))/wc);

l_22_wc=Gwc(2,2)*(1+(1/(1i*wc*T2)));
K2=1/(abs(l_22_wc));

f11=K1*(1+(1/(s*T1)));
f12=0;
f21=0;
f22=K2*(1+(1/(s*T2)));
F=[f11, f12; f21, f22];

L=G*F;

[Gm1, Pm1, wcg1, wc1]=margin(L(1,1));
[Gm2, Pm2, wcg2, wc2]=margin(L(2,2));
figure(1)
bode(L(1,1))
hold on
bode(L(2,2))
hold off

Pm1
wc1
Pm2
wc2


%%

S=(eye(2)+G*F)^-1;
T=((eye(2)+G*F)^-1)*G*F;

figure(2)
sigma(S)
hold on
sigma(T)








