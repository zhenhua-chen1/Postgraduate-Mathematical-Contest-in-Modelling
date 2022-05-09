function [Ca,R_c]=Dijkstra_apprach(cij,s,t)
%% step0：start
n=size(cij,1);%确定节点个数;
a=ones(n,n);%确定标号矩阵;
L=struct('cij',a,'eij',a);%标号寄存;
L.cij=cij;%保存燃油系数
n=size(cij,1);%确定节点个数;
path_c=zeros(n,n);%保存路径选择;

%% 确定可达路径
for i=1:n
    for j=1:n
        if cij(i,j)~=100000;
            path_c(i,j)=j; %确定可达路径;
        end
    end
end

%% step1：find least cost node;
for k=1:n
    for i=1:n
        for j=1:n
            if L.cij(i,k)+cij(k,j)<L.cij(i,j)
                L.cij(i,j)=L.cij(i,k)+cij(k,j); % calculate cost to each;
                path_c(i,j)=path_c(i,k);   %save;
            end
        end
    end
end

%% step2:update


%% output the pair of OD;
Ca=zeros(0,0);
R_c=s;
while 1
    if s==t  %输出每个路径选择的最短路径;
        Ca=fliplr(Ca);
        Ca=[0,Ca];%输出每个燃油路径选择的最短路径;
        return
    end
    Ca=[Ca,L.cij(s,t)]
    R_c=[R_c,path_c(s,t)];
    s=path_c(s,t);
end
end