function [err_std] = data_err(data,data_obs)
%% DATA_ERR 计算数据误差 并生成一个对角矩阵

err=data_obs-data;
err_std=zeros(size(err,2),size(err,2));
for j=1:size(err,2)
    err_std(j,j)=std(err(:,j));
end
end

