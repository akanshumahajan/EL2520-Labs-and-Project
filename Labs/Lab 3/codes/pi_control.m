%% Function for calculating f_j(s)

function f_js = pi_control(k_j, t_ij)
    f_js = TransferFn
    f_js.num = [k_j*t_ij k_j];
    f_js.den = [t_ij 0];
    f_js = f_js.transfer_fn();
end