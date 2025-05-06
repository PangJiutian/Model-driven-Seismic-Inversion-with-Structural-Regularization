function [noise_data] = add_noise(data,percent,maxdata)
%% add_noise 向数据中加入高斯白噪声

if nargin<3
    data_normal=data./max(data);
else
    data_normal=data./maxdata;
end
nosie = 2 * (rand(1, size(data,1)) - 0.5)*percent;
if nargin<3
    noise_data=(data_normal+nosie').*max(data);
    nosie=nosie.*max(data);
else
    noise_data=(data_normal+nosie).*maxdata;
    nosie=nosie.*maxdata;
end

end

