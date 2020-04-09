%% Function for calculating loop gain

function [L, mag] = loop_gain_fn_mag(g, t_ij,w_c)
    
    L_dash = TransferFn;
    L_dash.num = [t_ij 1];
    L_dash.den = [t_ij 0];
    L_dash = L_dash.transfer_fn();
    
    L = multiply_tf(g, L_dash.sys_tf)
    clear L_dash;
    
    [mag,phase] = bode(L,w_c);
    clear phase;
end