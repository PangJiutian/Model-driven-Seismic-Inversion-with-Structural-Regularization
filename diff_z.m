function [DZ,DZ_N] = diff_z(n,constant)
%% 差分矩阵 DZ为正常差分矩阵 DZ_N为补充最后一行的差分矩阵

DZ=zeros(n-1,n);
for i=1:n-1
    for j=1:n
        if i==j
            DZ(i,j)=-constant;
        elseif j==i+1
            DZ(i,j)=constant;
        else
            DZ(i,j)=0;
        end
    end
end
%利用前向差分 后向差分 最后一个数据利用后向差分
DZ_N=zeros(n,n);
DZ_N(1:end-1,:)=DZ;
DZ_N(end,:)=DZ(end,:);
end

