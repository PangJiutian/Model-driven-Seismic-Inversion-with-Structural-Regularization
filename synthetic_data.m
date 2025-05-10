function [w_t,wavelet,r,imp,conv_wt,conv_wt_1,record] = synthetic_data(f0,wavelet_len,dt,vp,den,imp) 
%% 合成记录

% ricker子波
w_t=((-ceil(wavelet_len/2)):1:ceil((wavelet_len/2)))*dt;
wavelet=(1-2*(pi*f0*(w_t)).^2).*exp(-(pi*f0*(w_t)).^2);

% 反射系数
if nargin<=5
    imp=log(vp.*den);
    [dz,~] = diff_z(size(imp,1),0.5);
    r=dz*imp;
else
    imp=log(imp);
    [dz,~] = diff_z(size(imp,1),0.5);
    r=dz*imp;
end

% 褶积矩阵
conv_wt_initial=zeros(length(wavelet)+size(r,1)-1,size(r,1));
for j=1:size(r,1)
    conv_wt_initial((j:length(wavelet)+j-1),j)=wavelet;              %构建子波褶积矩阵 每列依次依次向下移一位 长度为子波长度
end
conv_wt=conv_wt_initial(ceil(wavelet_len/2)+1:ceil(wavelet_len/2)+size(r,1),:);  %对齐

% 合成记录
record=conv_wt*r;

conv_wt_1=conv_wt*dz;
end

