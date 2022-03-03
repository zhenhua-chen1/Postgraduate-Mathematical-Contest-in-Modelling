clc
clear all
DataGet()
load data 

%% 定义决策变量
xij=binvar(Z,N);
yj=binvar(1,N);
disp('决策变量定义完成')

%% 定义目标函数
max=sum(sum(xij));
min=sum(yj);
disp('目标函数定义完成')

%% 定义约束条件
CX=[]; 
for i1=1:Z
    for i2=1:Z
        if i1~=i2
            for j=1:N
                CX=[CX;xij(i1,j)+xij(i2,j)<=1-Bii(i1,i2)];
            end
        end
    end
end

for i=1:Z
    for j=1:N
        CX=[CX;xij(i,j)<=yj(j),xij(i,j)<=Aij(i,j)];
    end
end

for j=1:N
    CX=[CX;sum(xij(i,:),2)==1];
end

disp('约束条件定义完成，开始求解')
opt = sdpsettings('solver','mosek'); % set solver, ‘cplex’
Sol = optimize(CX,-max+min,opt);

min=double(min)
max=double(max)
xij=double(xij)
yi=double(yj)
