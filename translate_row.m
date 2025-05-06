function [s] = translate_row(A)
%%  将一个矩阵写成一个列向量

row=size(A,2);
s=[];
for j = 1:row
    current= A(:,j);  % 获取当前列向量
    s=[s;current(:)]; % 将列向量转换为列并连接到结果向量
end

end

