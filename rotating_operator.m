function [Rparl,Rparl_1] = rotating_operator(record,dip_pwd,A,B)
%% 计算旋转矩阵

[row,col]=size(record);
% record=get_low(record,3,1);

Dx_two=diff_x(row+1,2,1);
Dx_two=Dx_two(1:row+1,:);
Dz_two=Dx_two*0;
Dz_two_last=Dx_two*0;
Rparl = cell(col, 1);


% 旋转矩阵
qcos=cos(dip_pwd);
qsin=sin(dip_pwd);
qcos_1=A;
qsin_1=B;
% Dx=sparse(diff_x(row+1,col,1));
[~,difz]=diff_z(row+1,1);
Dz_two(1:row+1,1:row+1)=difz;
Dz_two_last(1:row+1,row+2:end)=difz;

%% 检测无梯度的地方

DX=sparse(Dx_two);
DZ=sparse(Dz_two);

for i=1:col
    if i~=col
        Rparl{i,1}=sparse(diag(qcos(:,i)))*DX+sparse(diag(qsin(:,i)))*DZ;
        Rparl{i,1}=full(Rparl{i,1});
%         Rparl_1{i,1}=sparse(diag(qcos_1(:,i)))*DX+sparse(diag(qsin_1(:,i)))*DZ;
%         Rparl_1{i,1}=full(Rparl_1{i,1});
    else
        Rparl{i,1}=sparse(diag(qcos(:,i)))*sparse(Dx_two)+sparse(diag(qsin(:,i)))*sparse(Dz_two_last);
        Rparl{i,1}=full(Rparl{i,1});
%         Rparl_1{i,1}=sparse(diag(qcos_1(:,i)))*DX+sparse(diag(qsin_1(:,i)))*DZ;
%         Rparl_1{i,1}=full(Rparl_1{i,1});
    end
end

% Qcos=sparse(diag(translate_row(qcos)));
% Qsin=sparse(diag(translate_row(qsin)));
% Dz=sparse(comine_diag(difz,col));
% Qcos_gpu=gpuArray(Qcos);
% Qsin_gpu=gpuArray(Qsin);
% Dx_gpu=gpuArray(Dx);
% Dz_gpu=gpuArray(Dz);
% 
% % 结构算子
% temp=Qcos_gpu*Dx_gpu+Qsin_gpu*Dz_gpu;
% Rparl=full(gather(temp));
% Rperp=-Qsin*Dx+Qcos*Dz;
disp("dip finished")
end

