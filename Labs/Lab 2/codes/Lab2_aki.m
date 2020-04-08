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

%% 
