clear;close all;clc
%% 参数设置

f0=30;           %测试角度时采用18    正常采用55    
dt=0.001; 
wavelet_len=100; %测试角度时采用120   正常采用80
noise_1=0.1;  

load('vp.mat')
load("den.mat")
vp_1 = vp(500:500+551,1:10:end);
den_1 = den(500:500+551,1:10:end);
AI_new=vp_1.*den_1;

%% 合成记录

[w_t,wavelet,r,imp,conv_wt,conv_wt_1,record] = synthetic_data(f0,wavelet_len,dt,AI_new,AI_new,AI_new) ;

%% 低频背景

[imp_low,~] = get_low(imp,10,100);

figure;
imagesc(imp);
xlabel('Trace');
ylabel('TIME');
figure;
imagesc(imp_low);
xlabel('Trace');
ylabel('TIME');

figure;
wigb(record);
xlabel('Trace');
ylabel('Time');

%% 加噪

record_noise_1=add_noise(record,noise_1);

%% PWD和结构张量
[~,dip_pwd] = caclulate_angle(record);
S_T = struct_tensor(record);
figure;
imagesc(S_T.angle);
xlabel('Degree');
ylabel('Time');

%% 结构算子 
[Rparl,Rparl_1] = rotating_operator(record,angle_pwd,S_T.cosa,S_T.cosb);

%% 迭代准备

[G,d,R1,R1_1,m_initial] = prepare(conv_wt_1,record_noise_1,Rparl,Rparl_1,imp_low);
%% 迭代求解

[m_pwd,m_tensor,m_no]= lteration(G,d,R1,R1_1,m_initial,size(imp_low,2),size(imp_low,1));
%% results

m_pwd_10=m_pwd(:,1:40:end);
m_tensor_10=m_tensor(:,1:40:end);
m_no_10=m_no(:,1:40:end);
imp_10=imp(:,1:40:end);
% % 
% % RMSE_1 = sqrt(mean((m_pwd_10(:)-imp_10(:)).^2));
% % RMSE_2 = sqrt(mean((m_tensor_10(:)-imp_10(:)).^2));
% % RMSE_3 = sqrt(mean((m_no_10(:)-imp_10(:)).^2));
% % 
% figure;
% imagesc(m_pwd);
% xlabel('Trace');
% ylabel('TIME');
% title('利用PWD估计倾角')
% figure;
% imagesc(m_tensor);
% xlabel('Trace');
% ylabel('TIME');
% title('利用结构张量估计倾角')
% figure;
% imagesc(m_no);
% xlabel('Trace');
% ylabel('TIME');
% title('无约束')
% 
% figure;
% imagesc(abs(m_pwd-imp));
% figure;
% imagesc(abs(m_tensor-imp));
% figure;
% imagesc(abs(m_no-imp));


%% angle test

% figure 
% plot(angle_pwd(:,250),'b');hold on;
% plot(S_T.angle(:,250),'m');
% legend('pwd','tensor');
% xlabel('TIME');
% ylabel('Degree');
% title('250 trace')


% figure 
% plot(m_pwd(:,250)-imp(:,250),'b');hold on;
% plot(m_tensor(:,250)-imp(:,250),'r');hold on;
% plot(m_no(:,250)-imp(:,250),'m');
 
% figure 
% subplot(3,1,1)
% imagesc(angle_direct);
% subplot(3,1,2)
% imagesc(angle_pwd);
% subplot(3,1,3)
% imagesc(S_T.angle)
