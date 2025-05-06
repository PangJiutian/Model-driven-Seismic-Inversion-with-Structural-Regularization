function [B] = comine_diag(A,num)
%% 将小矩阵A放在B的对角线元素上构成一个大矩阵 num个A

B = [];
for ii = 1 : num
    B = blkdiag(B,A);       %构建对角矩阵
end

end

