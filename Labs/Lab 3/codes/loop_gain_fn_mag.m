%% Function for calculating loop gain

function [L, mag] = loop_gain_fn_mag(g, t_ij,w_c)
    
    L_dash = TransferFn;
    L_dash.num = [t_ij 1];
    L_dash.den = [t_ij 0];
    L_dash = L_dash.transfer_fn();
    
    L = TransferFn;
    L.sys_tf = multiply_tf(g, L_dash.sys_tf);
    L = L.num_den();
    clear L_dash;
    
    [mag,phase] = bode(L.sys_tf,w_c);
    clear phase;
end