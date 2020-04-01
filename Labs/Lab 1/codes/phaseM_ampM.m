function [Gm, pm, wp, wc] = phaseM_ampM(tf1, tf2)
    [Gm, pm, wp, wc]= margin(tf1 * tf2);
end