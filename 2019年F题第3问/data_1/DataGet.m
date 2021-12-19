 function DataGet()
% 这个是数据文件，所有计算数据在此设置
mp=0.8; %校正成功的概率
data = xlsread('data.xlsx'); %提取数据;
data(1,5)=3;
NodeAmount =length(data); %坐标点的个数;
pos = data(1:NodeAmount,2:4);
dij=zeros(NodeAmount,NodeAmount);%坐标点的欧氏距离;
% lij=zeros(NodeAmount,NodeAmount);%坐标点的弧度;
% Rij=zeros(NodeAmount,NodeAmount);%任意两点的半径;
ess=data(2:NodeAmount-1,5);
prob=data(2:NodeAmount-1,6);
% nodetype= [0,ess,0]'; %提取校正点;
for i = 1:NodeAmount
   for j = i+1:NodeAmount
        dij(i,j)=sqrt((pos(i,1)-pos(j,1))^2+(pos(i,2)-pos(j,2))^2+(pos(i,3)-pos(j,3))^2);
        dij(j,i)=dij(i,j);
   end
end
Delta=0.001;%最小校正单位;
theta=30;%最大修正单位;
alhpa_1=25;
alhpa_2=15;
Beta_1=20;
Beta_2=25;
MaxR = 14500;%最大转弯半径;
save data

 end

% D=zeros(row,row);
% for i=1:row
%     for j=i+1:row
%         D(i,j)=((a(i,1)-a(j,1))^2+(a(i,2)-a(j,2))^2)^0.5;
%         D(j,i)=D(i,j);
%     end
% end




