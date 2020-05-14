clear all, close all, clc
sysmp=minphase;
s=tf('s');

A=[-0.05645, 0, 0.02572, 0; 0, -0.05187, 0, 0.0213; 0, 0, -0.02572, 0; 0, 0, 0, -0.0213];
B=[0.174, 0; 0, 0.1506; 0, 0.09038; 0.1044, 0];
C=[0.2, 0, 0, 0; 0, 0.2, 0, 0];
D=[0, 0; 0, 0];

G=C*((s*eye(4)-A)^-1)*B+D;


%%

Gf=@(w) [0.0348/(w+0.05645), 0.0004447/((w)^2+0.07317*(w)+0.001105); 0.0004649/((w)^2+0.08217*(w)+0.001452), 0.03012/(w+0.05187)];
V_sigma=[];
wv=[];
for w=10.^[-2:1:2]
    G2=Gf(w).'*Gf(w);
    V_sigma=[V_sigma, sqrt(eig(G2))];
    wv=[wv, w];
end

loglog(wv, V_sigma(1,:))
loglog(wv, V_sigma(2,:))

bode(G)

wmax=0;
G0=Gf(0);
sigma=eig(G0.'*G0);

Hinf=max(sigma)

%%

RGA=(G0.'*G0).*(((G0.'*G0)^-1).')
disp('The off diagonal RGA elements are negative, whilst the other two elements are bit less than 5. Thus decentralized control with the coupling input1<-->output1 and input2<-->output2 is not eally recommended, but at least better than input2<-->output1 and input1<-->output2 recommended.')

%%
hold off

sysmp=nonminphase;

Anm=[-0.05106, 0, 0.08582, 0; 0, -0.04692, 0, 0.09089; 0, 0, -0.08582, 0; 0, 0, 0, -0.09089];
Bnm=[0.1044, 0; 0, 0.09038; 0, 01506; 0.174, 0];
Cnm=[0.2, 0, 0, 0; 0, 0.2, 0, 0];
Dnm=[0, 0; 0, 0];

Gnm=Cnm*((s*eye(4)-Anm)^-1)*Bnm+Dnm;

%%
Gfnm=@(w) [0.02088/(w+0.05106), 0.003163/(w^2+0.01378*w+0.004265); 25.85/(w^2+0.1369*w+0.004382), 0.01808/(w+0.04692)];

V_sigmanm=[];
wvnm=[];
for w=10.^[-3:0.1:1]
    G2nm=Gfnm(w).'*Gfnm(w);
    V_sigmanm=[V_sigmanm, sqrt(eig(G2nm))];
    wvnm=[wvnm, w];
end

loglog(wvnm, V_sigmanm(1,:));
hold on
loglog(wvnm, V_sigmanm(2,:));

%bode(Gm)

wmaxnm=0;
Gmaxnm=Gfnm(0);
sigmanm=eig(Gmaxnm.'*Gmaxnm);

Hinfnm=max(sigmanm)

%%
format long
RGAnm=(Gmaxnm.'*Gmaxnm).*(((Gmaxnm.'*Gmaxnm)^-1).')
disp('The off diagonal has two elements close to 1, whilst the other diagonal has negative elements. Thus, the pairing should be input1<-->output1; input2<-->output2 for a fairly decent control.')
