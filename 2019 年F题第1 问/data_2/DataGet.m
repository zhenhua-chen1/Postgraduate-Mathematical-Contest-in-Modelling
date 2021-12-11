 function DataGet()
% 这个是数据文件，所有计算数据在此设置
data = xlsread('data.xlsx'); %提取数据;
data(1,5)=3;
NodeAmount =length(data); %坐标点的个数;
pos = data(1:NodeAmount,2:4);
dij=zeros(NodeAmount,NodeAmount);
ess= data(2:NodeAmount-1,5)' ; %提取校正点;
%% 网络图参数
A=1;% 选择A点;
B=NodeAmount; % 选择B点;

for i = 1:NodeAmount
   for j = i+1:NodeAmount
        dij(i,j)=sqrt((pos(i,1)-pos(j,1))^2+(pos(i,2)-pos(j,2))^2+(pos(i,3)-pos(j,3))^2);
        dij(j,i)=dij(i,j);
   end
end
Delta=0.001;%最小校正单位;
theta=20;%最大修正单位;
alhpa_1=20;
alhpa_2=10;
Beta_1=15;
Beta_2=20;

%% 粒子群算法参数
PSwarmSize=100;
PSize=613;
IsStep=0;
IsDraw=1;
IterMax=20;
IsPlot=1;
save data

 end

% D=zeros(row,row);
% for i=1:row
%     for j=i+1:row
%         D(i,j)=((a(i,1)-a(j,1))^2+(a(i,2)-a(j,2))^2)^0.5;
%         D(j,i)=D(i,j);
%     end
% end




