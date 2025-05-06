function [DX] = diff_x(row,col,constant)
%% 利用DX*L完成对L的行求导 L为一个长的列向量 DX1为正常的少一行的差分矩阵

r=row*col-row;
c=row*col;
DX1=zeros(r,c);
for i=1:r
    for j=1:c
        if i==j
            DX1(i,j)=-constant;
        elseif j==i+row
            DX1(i,j)=constant;
        else
            DX1(i,j)=0;
        end
    end
end
% 利用向前向后差分补充
DX=zeros(r+row,c);
DX(1:end-row,:)=DX1;
DX(end-row+1:end,:)=DX1(end-row+1:end,:);

end

