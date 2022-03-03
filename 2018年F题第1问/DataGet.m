function DataGet()
%% 读取数据
data1=xlsread('InputData.xlsx','Pucks');
data2=xlsread('InputData.xlsx','Tickets');
data3=xlsread('InputData.xlsx','Gates');
Z=length(data1);%飞机总数
N=length(data3);%登机口得数量
ta_i=data1(:,17)*24*60;%到达时刻
td_i=data1(:,18)*24*60;%出发时刻
Bii=zeros(Z,Z);

%% 求出Aij
arrive_i=data1(:,3);
depart_i=data1(:,8);
size_i=data1(:,5);%航班机体类型
arrive_j=data3(:,1);
depart_j=data3(:,2);
size_j=data3(:,3);%机体类型
Aij=zeros(Z,N);
arrive_ij=zeros(Z,N);
depart_ij=zeros(Z,N);
size_ij=zeros(Z,N);
for i=1:Z
    for j=1:N
        if arrive_i(i)==arrive_j(j)
            arrive_ij(i,j)=1;
        elseif arrive_j(j)==3
             arrive_ij(i,j)=1; 
        end
        if depart_i(i)==depart_j(j)
            depart_ij(i,j)=1;
        elseif depart_j(j)==3
             depart_ij(i,j)=1; 
        end
        if size_i(i)==size_j(j)
            size_ij(i,j)=1;
        end
    end
end
Aij=arrive_ij.*depart_ij.*size_ij;%i航班是否与登机口j相匹配

for i1=1:Z
    for i2=1:Z
        if i1~=i2 && ta_i(i2)-td_i(i1)>=45
            Bii(i2,i1)=1;   %%判断两个航班是否冲突
        end
    end
end
save data

end