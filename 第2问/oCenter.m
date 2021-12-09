function [x,y,z] = oCenter(Re_i2)
load data
Re_i=Re_i2;
V_oil=Re_i/rho;%油面体积
h_oil=V_oil./(size_i(:,1).*size_i(:,2));%求油的高度
z=pos_i(:,3)-(size_i(:,3)/2-h_oil/2);%求各个油面质心
z=z'*Re_i/sum(Re_i);%求飞行器z的质心
x=pos_i(:,1)'*Re_i/(sum(Re_i)+3000);%求飞行器x的质心
y=pos_i(:,2)'*Re_i/(sum(Re_i)+3000);;%求飞行器y的质心
end

