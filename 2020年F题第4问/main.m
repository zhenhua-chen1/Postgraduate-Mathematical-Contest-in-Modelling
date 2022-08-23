clc
clear 
close all
dbstop if error
%Dataget()
load data
mt=zeros(T,1);
supply_oil=zeros(T,box);%供油策略
c1_t=zeros(T,3);
Re_i=origin_i*rho;
step=zeros(1,box);%记录每秒供油次数
epsilon=0.0001;%最小供油量
t=1;

%% 调用贪心算法
tic
while t<=T
    if  consum_eng(t)~=0
        box_i=find_box(t,Re_i,epsilon);%利用贪心策略找供油箱    
        [mt,supply_oil,c1_t,Re_i,t]=box_value(box_i,mt,supply_oil,c1_t,Re_i,t,epsilon);%找出60s偏差,60s供油量，剩余油量，执质心

    else
         [x,y,z] = oCenter(Re_i,data_angle(t));
         mt(t) = Deviation([x,y,z]); %求出当前偏差
         c1_t(t,:)=[x,y,z];
    end
 t=t+1;
 disp(['计算到',num2str(t),'s'])
end
toc

%% 画图
figure(1)
plot3(c1_t(:,1),c1_t(:,2),c1_t(:,3))
hold on
% plot3(c0_t(:,1),c0_t(:,2),c0_t(:,3))
% hold on
% axis([-1 10 -1 10 -1 10])
title('质心变化曲线')
figure(2)
% subplot(2,1,1)
% hold on
% plot(supply_oil(:,1))
subplot(6,1,1)
plot(supply_oil(:,1))
title('6个邮箱质心变化曲线')
subplot(6,1,2)
plot(supply_oil(:,2))
subplot(6,1,3)
plot(supply_oil(:,3))
subplot(6,1,4)
plot(supply_oil(:,4))
subplot(6,1,5)
plot(supply_oil(:,5))
subplot(6,1,6)
plot(supply_oil(:,6))
hold on

figure(3)
plot(sum(supply_oil,2))
title('总油箱供油曲线')
min_value=max(mt)