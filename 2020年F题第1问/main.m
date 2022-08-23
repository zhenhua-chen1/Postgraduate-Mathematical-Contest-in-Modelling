t=7200;n=6;
pha=850;%油密度
Remain_oil=ones(t,n);
centroid_x=[];%质心x
centroid_y=[];%质心y
centroid_z=[];%质心z
centroid_x_per=zeros(t,n);%单个油瓶的质心x
centroid_z_per=zeros(t,n); %单个油瓶的质心z
per=[];%体积百分比为
S_oil=[];%油横截面积
Length_box=[1.5,2.2,2.4,1.7,2.4,2.4];%箱子长
width_box=[0.9,0.8,1.1,1.3,1.2,1];%箱子宽
height_box=[0.3,1.1,0.9,1.1,1,0.5];%箱子高
S_box=Length_box.*height_box;%箱子横截面积
pos_x=[8.91304348,6.91304348,-1.68695652,3.11304348,-5.28695652,-2.08695652];%x轴中心点
pos_y=[1.20652174,-1.39347826,1.20652174,0.60652174,-0.29347826,-1.49347826];%y轴中心点
pos_z=[0.61669004,0.21669004,-0.28330996,-0.18330996,0.41669004,0.21669004];%z轴中心点
V_box=Length_box.*width_box.*height_box;%箱子体积
Remain_oil(1,:)=[0.300000000000000 1.50000000000000 2.10000000000000 1.90000000000000 2.60000000000000 0.800000000000000]*pha;
data_angle=xlsread('supply_oil.xlsx');
data_angle=data_angle(:,2);
data_supply_oil=xlsread('附件2-问题1数据.xlsx');
supply_oil=data_supply_oil(:,2:7);
for i=2:t %油质量
    for j=1:n
        Remain_oil(i,j)=Remain_oil(i-1,j)-supply_oil(i,j);
        if j==1 %油箱1供油给油箱2
            Remain_oil(i,2)=Remain_oil(i-1,2)+supply_oil(i,j);
        elseif j==6 %油箱2供油给油箱6
            Remain_oil(i,5)=Remain_oil(i-1,5)+supply_oil(i,j);          
        end
    end
end
V_oil=Remain_oil/pha;%体积
for i=1:t %油质量
    per=[per;V_oil(i,:)./V_box];
    S_oil=[S_oil;V_oil(i,:)./width_box];%油横截面积;
end
for i=1:t %求单油质心
     for j=1:n
         [centroid_x_per(i,j),centroid_z_per(i,j)]=search_centrio(pos_x(j),pos_z(j),S_oil(i,j),Length_box(j),height_box(j),data_angle(i));
     end
end
centroid_x_per=real(centroid_x_per);
centroid_z_per=real(centroid_z_per);
% for i=1:t %求质心
%       centroid_y=[centroid_y; pos_y*Remain_oil(i,:)'/(sum(Remain_oil(i,:))+3000)];
%       centroid_x=[centroid_x;pos_x*Remain_oil(i,:)'/(sum(Remain_oil(i,:))+3000)];
%       centroid_z=[centroid_z;pos_z*Remain_oil(i,:)'/(sum(Remain_oil(i,:))+3000)];
% end
for i=1:t %求质心
      centroid_y=[centroid_y; pos_y*Remain_oil(i,:)'/(sum(Remain_oil(i,:))+3000)];
      centroid_x=[centroid_x;centroid_x_per(i,:)*Remain_oil(i,:)'/(sum(Remain_oil(i,:))+3000)];
      centroid_z=[centroid_z;centroid_z_per(i,:)*Remain_oil(i,:)'/(sum(Remain_oil(i,:))+3000)];
end
figure(1)
subplot(311);plot(centroid_x,'r-');title('x');
subplot(312);plot(centroid_y,'r-');title('y');
subplot(313);plot(centroid_z,'r-');title('z');
figure(2)
plot3(centroid_x,centroid_y,centroid_z);
title('质心变化曲线');
grid on
