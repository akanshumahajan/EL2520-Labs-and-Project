%% 
addpath(genpath('Lab 1'))

%% 
g1 = TransferFn ;
g1.num = [1 2];
g1.den = [1 2 3];
g1 = g1.transfer_fn();
%disp(g1)

g2 = TransferFn ;
g2.num = [1 2];
g2.den = [1 2 3];
g2 = g2.transfer_fn();
%disp(g2)

product_tf = multiply_tf(g1.sys_tf, g2.sys_tf);
[Gm, pm, wp, wc] = phaseM_ampM(g1.sys_tf, g2.sys_tf);

%% 4.2 Disturbance attenuation
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


%% 

constant = 1.16;
p1 = 5;
p2 = 7;
wi = (constant)* Wcp_d;

poles = TransferFn;
poles.num = [1];
poles.den = [1 (p1+p2) (p1*p2)]
%poles.den = [1 p1]; 
poles = poles.transfer_fn();

Ginv_Gd = TransferFn;
Ginv_Gd.sys_tf = multiply_tf(G_inv, Gd.sys_tf);
Ginv_Gd.sys_tf = multiply_tf(Ginv_Gd.sys_tf, poles.sys_tf); % proper fraction

Fy_new = TransferFn;
Fy_new.num = [1 wi];
Fy_new.den = [1 0];
Fy_new = Fy_new.transfer_fn();

Fy_new.sys_tf = multiply_tf(Fy_new.sys_tf, Ginv_Gd.sys_tf)



