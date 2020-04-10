classdef TransferFn
    properties
        num
        den
        sys_tf
    end
    methods
        function obj = transfer_fn(obj)
            if nargin ~= 0
                obj.sys_tf = tf(obj.num, obj.den);
            end
        end
        function obj = num_den(obj)
            [obj.num, obj.den] = tfdata(obj.sys_tf);
            obj.num = obj.num{1,1};
            obj.den = obj.den{1,1};
        end
        
        function bode_plot(obj)
            bode(obj.sys_tf)
        end
        function [m, p] = amp_phase(obj, w)
            [m, p]= bode(obj.sys_tf, w);
        end
        function step_res(obj)
            step(obj.sys_tf)
        end    
    end
end