function [data_low,data_high] = get_low(data,step,num)
%% GET_LOW 获取低频背景

data_low= data;
for k = 1:num
    for j = 1:size(data,2)
         data_low(:,j) = smooth( data_low(:,j),step);
    end
    for i = 1:size(data,1)
        data_low(i,:) =  smooth(data_low(i,:),step);
    end
end
data_high=data-data_low;
end

