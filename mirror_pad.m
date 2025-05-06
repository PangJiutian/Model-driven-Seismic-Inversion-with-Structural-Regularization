function [data_padded] = mirror_pad(data,length)
%% 镜像填充数据边界  边界作为反射轴
[row,col]=size(data);
data_padded=zeros(row+2*length,col+2*length);
data_padded(length+1:length+row,length+1:length+col)=data;
%生成镜面数据

for i=1:length
    %right and left
    data_padded(length+1:length+row,i)=data(:,1+length-i+1);
    data_padded(length+1:length+row,end+1-length+i-1)=data(:,end-1-i+1);

end

for i=1:length
    %up and down
    data_padded(length-i+1,:)=data_padded(length+2+i-1,:);
    data_padded(end-i+1,:)=data_padded(end-2*length+i-1,:);
end

end