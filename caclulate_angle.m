function [angle_direct,angle_pwd] = caclulate_angle(record)
%%  直接计算angle 
[row,col]=size(record);

% 对矩阵求导  列:diff*record 行:record*diff'
% [~,dz]=diff_z(row,1);
% [~,dx]=diff_z(col,1);
% rz=dz*record;
% rx=record*dx';
% [rx,rz]=caclulate_gradient(record);
% % 计算角度 
% angle_1=zeros(row,col);
% for i=1:size(rx,1)
%     for j=1:size(rz,2)
%         if rx(i,j)~=0 && rz(i,j)~=0
%             angle_1(i,j)=rad2deg(atan(rx(i,j)/rz(i,j)));
%         else
%             angle_1(i,j)=0;
%         end
%     end
% end
% 
% angle_direct=zeros(row+1,col);
% angle_direct(1:end-1,:)=angle_1;
% angle_direct(end,:)=angle_1(end,:);
% angle_direct=-angle_direct;
%% PWD

slope=zeros(row+1,col);
[slope(1:end-1,:)]=str_dip2d(record);
slope(end,:)=slope(end-1,:);

% for i=1:row
%     for j=1:col
%         if rx(i,j)==0 && rz(i,j)==0
%             slope(i,j)=0;
%         end   
%     end
% end

angle_pwd=rad2deg(atan(slope));
angle_direct = angle_pwd;
end

