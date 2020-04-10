%% Function for calculating t_ij

function t_ij = t_ij_pi(phi_m, w_c, g)
    [mag,phase] = bode(g,w_c);
    g11_arg = deg2rad(phase);
    clear mag phase;
    t_ij = (tan((phi_m)-(pi/2)-(g11_arg)))/(w_c);
end