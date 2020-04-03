function [Gm, pm, wp, wc] = phaseM_gainM(tf)
    [Gm, pm, wp, wc]= margin(tf)
end