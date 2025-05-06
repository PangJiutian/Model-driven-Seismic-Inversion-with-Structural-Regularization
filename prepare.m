function [G,d,R1,R1_1,m_initial] = prepare(conv_wt_1,record_noise_1,Rparl,Rparl_1,imp_low)
%% 为迭代做准备工作 两列一起算

[row,col]=size(imp_low);

R1=  Rparl;
R1_1=  Rparl_1;
d=record_noise_1;

m_long=translate_row(imp_low);
m_initial=cell(col, 1);
for i=1:col
    if i~=col
        m_initial{i}=m_long(1+(i-1)*row:(i+1)*row);
    else
        m_initial{i}=m_long(1+(i-2)*row:i*row);
    end
end

% m_high_long=translate_row(imp_high);
% m_high=cell(col, 1);
% for i=1:col
%     if i~=col
%         m_high{i}=m_high_long(1+(i-1)*row:(i+1)*row);
%     else
%         m_high{i}=m_high_long(1+(i-2)*row:i*row);
%     end
% end

G=cell(2, 1);
G{1,1}=zeros(size(conv_wt_1,1),2*size(conv_wt_1,2));
G{1,1}(:,1:size(conv_wt_1,2))=conv_wt_1;
G{2,1}=zeros(size(conv_wt_1,1),2*size(conv_wt_1,2));
G{2,1}(:,size(conv_wt_1,2)+1:end)=conv_wt_1;
disp("prepared")


% R1 = cell(col, 1);

% for i = 1:col
%     if i~=col
%         row_start=1+(i-1)*row;
%         row_end=i*row;
%         col_start=1+(i-1)*row;
%         col_end=(i+1)*row;
%     else
%         row_start=1+(i-1)*row;
%         row_end=i*row;
%         col_start=1+(i-2)*row;
%         col_end=(i)*row;
%     end
%     R1{i} = Rparl(row_start:row_end, col_start:col_end);
% end

% d_line=translate_row(record_noise_1);
% d=cell(col, 1);
% for i=1:col
%     if i~=col
%         d{i}=d_line(1+(i-1)*(row-1):(i+1)*(row-1));
%     else
%         d{i}=d_line(1+(i-2)*(row-1):i*(row-1));
%     end
% end
end

