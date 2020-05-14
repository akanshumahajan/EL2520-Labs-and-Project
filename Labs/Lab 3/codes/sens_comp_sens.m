%% Function for calculating Sensitivity transfer matrix
function [L, S, T] = sens_comp_sens(l11, l12, l21, l22)

    L_num = {l11.num l12.num;l21.num l22.num};
    L_den = {l11.den l12.den;l21.den l22.den};
    L = tf(L_num, L_den);
    
    I = eye(2);
    S_inv = (I + L);
    S = inv(S_inv);
    clear S_inv;
    
    T = (S * L); 
end