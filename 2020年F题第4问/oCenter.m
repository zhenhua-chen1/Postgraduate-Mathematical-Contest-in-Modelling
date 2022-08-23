function [x,y,z] = oCenter(Re_i2,angle)
load data
Re_i=Re_i2;
V_oil=Re_i/rho;%油面体积
h_oil=V_oil./(size_i(:,1).*size_i(:,2));%求油的高度
s=V_oil./h_oil;
x_per=zeros(1,6);%单个油瓶的质心x
z_per=zeros(1,6); %单个油瓶的质心z
for j=1:6
    [x_per(j),z_per(j)]=search_centrio(pos_i(j,1),pos_i(j,3),s(j),size_i(j,1),size_i(j,3),angle);
end
x_per=real(x_per);
z_per=real(z_per);
x=x_per*Re_i/(sum(Re_i)+3000);
z=z_per*Re_i/(sum(Re_i)+3000);
y=pos_i(:,2)'*Re_i/(sum(Re_i)+3000);%求飞行器y的质心
end

