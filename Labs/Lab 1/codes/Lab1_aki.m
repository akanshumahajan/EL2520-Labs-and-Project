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

g = TransferFn;
g.num = [20];
g.den = [1/400 21/400 21/20 1]
g = g.transfer_fn();
 
gd = TransferFn;
gd.num = [10];
gd.den = [1 1]
gd = gd.transfer_fn();