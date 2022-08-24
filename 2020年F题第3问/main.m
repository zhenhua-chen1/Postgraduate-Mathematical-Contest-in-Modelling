clc
clear 
close all
dbstop if error
%Dataget()
load data
tic
mt=inf*ones(T,1);
max_iter=10;
epsilon=0.0001;%最小供油量
for i=1:max_iter
    temp_mt=inf*ones(T,1);
    temp_supply_oil=zeros(T,box);%供油策略
    temp_c1_t=zeros(T,3);
    temp_Re_i=origin_i*rho.*abs(randn(box,1));
    temp_Re_i2=temp_Re_i;
    t=1;
%% 调用初始供油
    while t<=T
        if  consum_eng(t)~=0
            box_i=find_box(t,temp_Re_i,epsilon);%利用贪心策略找供油箱    
            [temp_mt,temp_supply_oil,temp_c1_t,temp_Re_i,t]=box_value(box_i,temp_mt,temp_supply_oil,temp_c1_t,temp_Re_i,t,epsilon);%找出60s偏差,60s供油量，剩余油量，执质心

        else
             [x,y,z] = oCenter(temp_Re_i);
             temp_mt(t) = Deviation([x,y,z],t); %求出当前偏差
             temp_c1_t(t,:)=[x,y,z];
        end
        t=t+1;
        disp(['第',num2str(i),'次迭代','计算到',num2str(t),'s'])
    end
    if max(temp_mt)<=max(mt)
        supply_oil=temp_supply_oil;
        mt=temp_mt;
        Re_i=temp_Re_i2;
        c1_t=temp_c1_t;
    end
end
toc

%% 画图
figure(1)
plot3(c1_t(:,1),c1_t(:,2),c1_t(:,3))
hold on
% plot3(c2_t(:,1),c2_t(:,2),c2_t(:,3))
% hold on
% axis([-1 10 -1 10 -1 10])
title('质心变化曲线')
figure(2)
% subplot(2,1,1)
% hold on
% plot(supply_oil(:,1))
subplot(6,1,1)
plot(supply_oil(:,1))
title('6个油箱质心变化曲线')
subplot(6,1,2)
plot(supply_oil(:,2))
subplot(6,1,3)
plot(supply_oil(:,3))
subplot(6,1,4)
plot(supply_oil(:,4))
subpl ot(6,1,5)
plot(supply_oil(:,5))
subplot(6,1,6)
plot(supply_oil(:,6))
hold on

figure(3)
plot(sum(supply_oil,2))
hold on
% plot(consum_eng)
% hold on
title('总油箱供油曲线')
min_value=max(mt)
disp('Initial oil volume is ')
Re_i