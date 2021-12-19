clc
clear 
close all
%% 读取数据
DataGet()
load data


%% 处理数据
A=1;% 选择A点;
B=NodeAmount;% 选择B点;
Itex_max=1000;%迭代次数
all_e_a=[];
all_e_h=[];
n=20;
best_path=zeros(Itex_max,20);
tic

%% 调用算法
for i=1:Itex_max
    [c,po,e_h,e_a,e_h_1,e_a_1,prob_e]=Dijkstra_2(A,dij);
    [min_cost,path_len,path]=Search_path(B,NodeAmount,c,A,po);
    best_path(i,1:path_len)=path;
    best_path(i,path_len+1)=min_cost;
    all_e_a=[all_e_a;e_a];
    all_e_h=[all_e_h;e_h];
end

%% 提取结果
[path,idx,M]=unique(best_path,'rows');%去除重复路径
e_a=all_e_a(idx,:);%提取误差
e_h=all_e_h(idx,:);%提取误差
N=tabulate(M);%找到路径出现频率
[pro,idex]=max(N(:,2));
pro=pro/Itex_max*100;%求出概率
path=path(idex,:);
e_a=e_a(idex,:);%提取误差
e_h=e_h(idex,:);%提取误差
path(find(path==0))=[];
path=path(1:end-1);
min_cost=path(end);

disp(['该路径:',num2str(path-1),' 出现的概率为:',num2str(pro),'%'])
disp(['水平误差为：',(num2str((e_a(path))))])
disp(['垂直误差为：',(num2str((e_h(path))))])
toc
disp('开始画图')

%% 画图
draw(path,pos)

