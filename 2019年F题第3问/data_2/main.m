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

disp(['该路径:',num2str(path-1),'出现的概率为:',num2str(pro),'%'])
disp(['水平误差为：',(num2str((e_a(path))))])
disp(['垂直误差为：',(num2str((e_h(path))))])
toc
disp('开始画图')

%% 画图
draw(path,pos)

% % 提取坐标点
% pos_2=[];
% for i=1:path_len
%     pos_2=[pos_2;path(i),pos(path(i),1),pos(path(i),2),pos(path(i),3)];
% end
% x=pos_2(:,2);y=pos_2(:,3);z=pos_2(:,4);
% % 画图
% plot3(pos(1,1),pos(1,2),pos(1,3),'ko','MarkerFaceColor','k','MarkerSize',4);
% hold on
% plot3(pos(NodeAmount,1),pos(NodeAmount,2),pos(NodeAmount,3),'ko','MarkerFaceColor','k','MarkerSize',4);
% 
% for i=1:NodeAmount-2
%     if ess(i)==1
%         plot3(pos(i+1,1),pos(i+1,2),pos(i+1,3),'bo','MarkerFaceColor','b','MarkerSize',4);
%         hold on
%     else
%          plot3(pos(i+1,1),pos(i+1,2),pos(i+1,3),'yo','MarkerFaceColor','y','MarkerSize',4);
%          hold on
%     end
% end
% 
% hold on
% for i = 1:path_len
%     Str = int2str(path_len(i));
%     text(pos_2(i,2)+1/100,pos_2(i,3)+1/100,pos_2(i,4)+1/100,Str,'FontName','Times New Roman','FontSize',12);
%     hold on;
% end
% for i = 1:path_len-1
%      plot3([x(i),x(i+1)],[y(i),y(i+1)],[z(i),z(i+1)],'k');
%      hold on;
%      grid on;
% end
% 	plot3([x(path_len-1),x(path_len)],[y(path_len-1),y(path_len)],[z(path_len-1),z(path_len)],'k');
% 修正节点
% for i=1:path_len
%     path(i)=path(i)-1
% end
% plot3([x(1),x(2)],[y(1),y(2)],[z(1),z(2)],'r');
% hold on;
% % plot3([pos(1,1),pos(2,1)],[pos(1,2),pos(2,2)],[pos(1,3),pos(2,3)],'k');
% % hold on;
