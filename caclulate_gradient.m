function [g_x,g_z] = caclulate_gradient(data)
%% 计算二维矩阵梯度

[R,C]=size(data);
[~,dz_full]=diff_z(R,1);
[~,dx_full]=diff_z(C,1);

g_z=dz_full*data;
g_x=data*dx_full';

end

