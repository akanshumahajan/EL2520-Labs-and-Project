%% 
addpath(genpath('Labs'))

%% Minimum Phase
clear all; close all; clc;

sys_minphase = minphase();
%[num_tf1,den_tf1] = ss2tf(sys_minphase.A,sys_minphase.B,sys_minphase.C,sys_minphase.D, 1,2);
G_min = tf(sys_minphase)

% Individual Transfer Functions, poles and zeros
% #######

G11_min = TransferFn;
G11_min.num = G_min.Numerator{1,1};
G11_min.den = G_min.Denominator{1,1};
G11_min = G11_min.transfer_fn();
pole_G11_min = pole(G11_min.sys_tf);
zero_G11_min = zero(G11_min.sys_tf);


G12_min = TransferFn;
G12_min.num = G_min.Numerator{1,2};
G12_min.den = G_min.Denominator{1,2};
G12_min = G12_min.transfer_fn();
pole_G12_min = pole(G12_min.sys_tf);
zero_G12_min = zero(G12_min.sys_tf);

G21_min = TransferFn;
G21_min.num = G_min.Numerator{2,1};
G21_min.den = G_min.Denominator{2,1};
G21_min = G21_min.transfer_fn();
pole_G21_min = pole(G21_min.sys_tf);
zero_G21_min = zero(G21_min.sys_tf);

G22_min = TransferFn;
G22_min.num = G_min.Numerator{2,2};
G22_min.den = G_min.Denominator{2,2};
G22_min = G22_min.transfer_fn();
pole_G22_min = pole(G22_min.sys_tf);
zero_G22_min = zero(G22_min.sys_tf);

% #######

% Poles and zeros of the multivariable system
% #######

pole_sys_minphase = pole(sys_minphase)
zero_sys_minphase = tzero(sys_minphase)

% #######

% Step Response for one input at a time
% #######

step(sys_minphase)
%figure
%step(G_min)        % The transfer function can also be used 

% #######

%% Decentralised Control for min phase case

phi_m = pi/3 ; % Intended phase margin
w_c   = 0.1 ; % intended crossover frequency for minimum phase

t_i1 = t_ij_pi(phi_m, w_c,G11_min.sys_tf);  % calling function to find t_i1
[L11, mag1] = loop_gain_fn_mag(G11_min.sys_tf, t_i1, w_c); % calling function to find magnitude
k_1 = 1/mag1;
f_1s = pi_control(k_1, t_i1); % calling function to find PI controller

figure
bode (L11.sys_tf); % Plotting f1(s)
[gm_l11,pm_l11,Wcg_l11,Wcp_l11]= phaseM_gainM(L11.sys_tf)

t_i2 = t_ij_pi(phi_m, w_c,G22_min.sys_tf);  % calling function to find t_i2
[L22, mag2] = loop_gain_fn_mag(G22_min.sys_tf, t_i2, w_c); % calling function to find magnitude
k_2 = 1/mag2;
f_2s = pi_control(k_2, t_i2); % calling function to find PI controller

figure
bode (L22.sys_tf); % Plotting f1(s)
[gm_l22,pm_l22,Wcg_l22,Wcp_l22]= phaseM_gainM(L22.sys_tf)


%% Non Minimum Phase

close all; clc;

sys_nonminphase = nonminphase();
%[num_tf1,den_tf1] = ss2tf(sys_minphase.A,sys_minphase.B,sys_minphase.C,sys_minphase.D, 1,2);
G_non_min = tf(sys_nonminphase)

% Individual Transfer Functions, poles and zeros
% #######

G11_non_min = TransferFn;
G11_non_min.num = G_non_min.Numerator{1,1};
G11_non_min.den = G_non_min.Denominator{1,1};
G11_non_min = G11_non_min.transfer_fn();
pole_G11_non_min = pole(G11_non_min.sys_tf);
zero_G11_non_min = zero(G11_non_min.sys_tf);


G12_non_min = TransferFn;
G12_non_min.num = G_non_min.Numerator{1,2};
G12_non_min.den = G_non_min.Denominator{1,2};
G12_non_min = G12_non_min.transfer_fn();
pole_G12_non_min = pole(G12_non_min.sys_tf);
zero_G12_non_min = zero(G12_non_min.sys_tf);

G21_non_min = TransferFn;
G21_non_min.num = G_non_min.Numerator{2,1};
G21_non_min.den = G_non_min.Denominator{2,1};
G21_non_min = G21_non_min.transfer_fn();
pole_G21_non_min = pole(G21_non_min.sys_tf);
zero_G21_non_min = zero(G21_non_min.sys_tf);

G22_non_min = TransferFn;
G22_non_min.num = G_non_min.Numerator{2,2};
G22_non_min.den = G_non_min.Denominator{2,2};
G22_non_min = G22_non_min.transfer_fn();
pole_G22_non_min = pole(G22_non_min.sys_tf);
zero_G22_non_min = zero(G22_non_min.sys_tf);

% #######

% Poles and zeros of the multivariable system
% #######

pole_sys_non_minphase = pole(sys_nonminphase)
zero_sys_non_minphase = tzero(sys_nonminphase)

% #######

% Step Response for one input at a time
% #######

step(sys_nonminphase)
%figure
%step(G_min)        % The transfer function can also be used 

% #######

%% Decentralised Control for non min phase case

phi_m_non = pi/3 ; % Intended phase margin
w_c_non   = 0.02 ; % intended crossover frequency for non minimum state

t_i3 = t_ij_pi(phi_m_non, w_c_non,G11_non_min.sys_tf);  % calling function to find t_i2
[L12, mag3] = loop_gain_fn_mag(G11_non_min.sys_tf, t_i3, w_c_non); % calling function to find magnitude
k_3 = 1/mag3;
f_3s = pi_control(k_3, t_i3); % calling function to find PI controller

figure
bode (L12.sys_tf); % Plotting f1(s)
[gm_l12,pm_l12,Wcg_l12,Wcp_l12]= phaseM_gainM(L12.sys_tf)

t_i4 = t_ij_pi(phi_m_non, w_c_non,G22_non_min.sys_tf);  % calling function to find t_i2
[L21, mag4] = loop_gain_fn_mag(G22_non_min.sys_tf, t_i4, w_c_non); % calling function to find magnitude
k_4 = 1/mag4;
f_4s = pi_control(k_4, t_i4); % calling function to find PI controller

figure
bode (L21.sys_tf); % Plotting f1(s)
[gm_l21,pm_l21,Wcg_l21,Wcp_l21]= phaseM_gainM(L21.sys_tf)

%% Calculating Sensitivity and Complimentary Sensitivity Functions

L11_min = TransferFn;
L11_min.sys_tf = multiply_tf(G11_min.sys_tf, f_1s.sys_tf);
L11_min = L11_min.num_den();

L12_min = TransferFn;
L12_min.sys_tf = multiply_tf(G12_min.sys_tf, f_2s.sys_tf);
L12_min = L12_min.num_den();

L21_min = TransferFn;
L21_min.sys_tf = multiply_tf(G21_min.sys_tf,f_1s.sys_tf);
L21_min = L21_min.num_den();

L22_min = TransferFn;
L22_min.sys_tf = G22_min.sys_tf*f_2s.sys_tf;
L22_min = L22_min.num_den();

[L_min, S, T] = sens_comp_sens(L11, L12, L21, L22); % seems to be wrong
figure
bode(L_min)
figure
sigma(S)
hold on
sigma(T)
%% Simulink Plot

F_num = {f_1s.num 0;0 f_2s.num};
F_den = {f_1s.den 1;1 f_2s.den};
F = tf(F_num, F_den);
G = G_min;
closedloop