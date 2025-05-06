function [patch] = create_patch(record,sqart_n)
%% 将剖面分割成块

[row,col]=size(record);

patch=cell(row-sqart_n+1,col-sqart_n+1);

for i=1:row-sqart_n+1
    for j=1:col-sqart_n+1
    patch{i,j}=record(i:sqart_n+i-1,j:sqart_n+j-1);
    end
end

end

