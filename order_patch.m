function [outputArg1,outputArg2] = order_patch(patch,record,sqart_n,B,sigma)
%% 块状排序

[row,col]=size(record);
N1=row-sqart_n+1;
N2=col-sqart_n+1;
Np=N1*N2;                             % patch总数

ordering=[];                 
unvisited=true(Np,1);                 % ture表示未被访问
start=randi(Np);  
unvisited(start)=false;               % false已访问
ordering=[ordering,start];            % 链接顺序

for m=1:Np
    % 将start定位到patch
    if mod(start,N1)==0
        i=N1;
        j=floor(start/Np1);
    else
        i=mod(start,N1);
        j=floor(start/Np1)+1;
    end

end

end

