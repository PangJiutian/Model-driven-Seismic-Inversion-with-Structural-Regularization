function [AI] = create_model(R,C)
%% 构造直线阻抗模型

r_1 = zeros(R,C);

for j=1:C
    r_1(10+ceil(j/2),j)=0.2;
    r_1(12+j,j)=0.2;
    r_1(14+ceil(j*2),j)=0.2;
end

AI_1=zeros(size(r_1));
AI_1(1,:)=6000;
for i=2:size(AI_1,1)
    AI_1(i,:) = (1 + r_1(i-1,:))./(1 - r_1(i-1,:)) .* AI_1(i-1,:);
end

AI=AI_1;

end

