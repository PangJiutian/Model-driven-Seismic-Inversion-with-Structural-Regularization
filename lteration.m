function [m_pwd,m_tensor,m_direct] = lteration(G,d,R1,R1_1,m_initial,col,row)
%% 优化函数
init_unlocbox();
verbose=1;
alfa=0.95;
lampda=0.05;
m_p=cell(col, 1);
m_s=cell(col, 1);
m_d=cell(col, 1);
% global GLOBAL_useGPU;
k=1;
for j=1:col
    fprintf('%d\n',k);

    d_new=d(:,j);
    if j~=col
        G_new=G{1,1};
    else
        G_new=G{2,1};
    end

    f1.grad=@(x)2*G_new'*(G_new*x-d_new);
    f1.eval=@(x)norm(G_new*x-d_new)^2;
    f1.beta=2*norm(G_new)^2;
    
    R1_new=R1{j,1};
    f2.grad=@(x)2*alfa*R1_new'*R1_new*x;
    f2.eval=@(x)alfa*norm(R1_new*x)^2;
    f2.beta=2*norm(R1_new)^2;

    R1_1_new=R1_1{j,1};
    f3.grad=@(x)2*alfa*R1_1_new'*R1_1_new*x;
    f3.eval=@(x)alfa*norm(R1_1_new*x)^2;
    f3.beta=2*norm(R1_1_new)^2;
   
%     f3.grad=@(x)2*lampda*(x-m_high_new);
%     f3.eval=@(x)lampda*norm(x-m_high_new)^2;
%     f3.beta=2;

%     L=R1{j,1};
%     param_tv.useGPU = GLOBAL_useGPU;
%     param_tv.verbose=verbose-1;
%     param_tv.maxit=100; 
%     f3.prox = @(x, T) prox_tv(x,lampda*T, param_tv); 
%     f3.eval = @(x) lampda*norm_tv(L*x); 
%     param_l1.verbose = verbose - 1;
%     f3.prox = @(x, T) prox_l1(x, lampda*T, param_l1);
%     f3.eval = @(x) lampda*norm_tv(L*x);

    param_solver.verbose=verbose; % display parameter
    param_solver.maxit=500;       % maximum iteration
    param_solver.tol=1e-5;        % tolerance to stop iterating
    param_solver.method='FISTA';  % desired method for solving the problem
    
    m_p{j} = solvep(m_initial{j,1},{f1,f2},param_solver);
    m_s{j} = solvep(m_initial{j,1},{f1,f3},param_solver);
    m_d{j} = solvep(m_initial{j,1},{f1},param_solver);
    k=k+1;
end

for j=1:col
    if j~=col
        m_pwd(:,j)=m_p{j}(1:row,:);
        m_tensor(:,j)=m_s{j}(1:row,:);
        m_direct(:,j)=m_d{j}(1:row,:);
    else
        m_pwd(:,j)=m_p{j}(row+1:end,:);
        m_tensor(:,j)=m_s{j}(row+1:end,:);
        m_direct(:,j)=m_d{j}(row+1:end,:);
    end
end

end

