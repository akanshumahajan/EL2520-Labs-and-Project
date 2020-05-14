%% 
addpath(genpath('Labs'))

%% 4.2.1 Disturbance attenuation
clear all; close all; clc;

s=tf('s');
G=1e4*(s+2)/(s+3)/(s+100)^2;
Hinf(G);

%% 
Fsim=tf(F); Gsim=G ;
% Edit parameters in macro.m
macro

%% 
G_0 = 1e4*(s+2)*(s-1)/(((s+2)*(s+3))*((s+100)^2));
%Hinf(G);

%% 
Fsim=tf(F); Gsim=G_0 ;
% Edit parameters in macro.m
macro
%% 



G = TransferFn;
G.num = [20];
G.den = [1/400 21/400 21/20 1];
G = G.transfer_fn();
 
Gd = TransferFn;
Gd.num = [10];
Gd.den = [1 1]
Gd = Gd.transfer_fn();

[Gm_d,Pm_d,Wcg_d,Wcp_d]= phaseM_gainM(Gd.sys_tf)

Fy = TransferFn;
Fyy = TransferFn;
G_inv = inv(G.sys_tf);
Fyy.num = [Wcp_d];
Fyy.den = [1 0];
Fyy = Fyy.transfer_fn();
Fy.sys_tf = multiply_tf(G_inv, Fyy.sys_tf)
clear Fyy

L = TransferFn;
L.sys_tf = multiply_tf(Fy.sys_tf, G.sys_tf);

S = TransferFn;
S.sys_tf = 1/ (1+L.sys_tf);

SGd = TransferFn;
SGd.sys_tf = multiply_tf(S.sys_tf, Gd.sys_tf);
%figure
%SGd.bode_plot()
figure
SGd.step_res()
stepinfo(SGd.sys_tf)


%% 4.2.1 Disturbance attenuation

close all; clc;
constant = 75;
p1 = 10000;
p2 = 2000;

%constant = 0.001;
%p1 = 1.25;
%p2 = 0.75;


wi = (constant)* Wcp_d;

poles = TransferFn;
poles.num = [p1*p2];
poles.den = [1 (p1+p2) (p1*p2)];
%poles.den = [1 p1]; 
poles = poles.transfer_fn();

Ginv_Gd = TransferFn;
Ginv_Gd.sys_tf = multiply_tf(G_inv, Gd.sys_tf); %improper fraction

Ginv_Gd.sys_tf = multiply_tf(Ginv_Gd.sys_tf, poles.sys_tf); % proper fraction

Fy_new = TransferFn;
Fy_new.num = [1 wi];
Fy_new.den = [1 0];
Fy_new = Fy_new.transfer_fn();

Fy_new.sys_tf = multiply_tf(Fy_new.sys_tf, Ginv_Gd.sys_tf);

L_new = TransferFn;
L_new.sys_tf = multiply_tf(Fy_new.sys_tf, G.sys_tf);

S_new = TransferFn;
S_new.sys_tf = 1/ (1+L_new.sys_tf);

SGd_new = TransferFn;
SGd_new.sys_tf = multiply_tf(S_new.sys_tf, Gd.sys_tf);

figure
SGd_new.bode_plot
figure
SGd_new.step_res
stepinfo(SGd.sys_tf)
%figure
%pzmap(SGd_new.sys_tf)
%figure
%nyquist(SGd_new.sys_tf)



