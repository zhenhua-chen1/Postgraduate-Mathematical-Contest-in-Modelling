clc
clear all
DataGet()
load data
fitness=inf;%适应性函数（中转时间）
Iter_max=100;%最大迭代次数
for iter=1:Iter_max
    temp_Cij=zeros(Z,N);
    temp_fitness=0;
    for p=1:Passenger
        i1=data2(p,2);
        i2=data2(p,4);
        pos1=find_pos(i1,date_a(p),data1(:,3),data1(:,16));%找到对应航班的索引；
        pos2=find_pos(i2,date_d(p),data1(:,8),data1(:,17));
        if ~isempty(pos1)&&~isempty(pos2)
                j1=find(Aij(pos1,:));%找到符合约束的登机口
                j1=is_coflict(pos1,j1,temp_Cij,Z,Bii);% 在j1点pos1与其他是否冲突
            if ~isempty(j1)
                j1=j1(ceil(rand(1)*length(j1)));%随机选一个登机口
                if sum(temp_Cij(pos1,:)==1)==0
                    temp_Cij2=temp_Cij;
                    temp_Cij2(pos1,j1)=1;
                end
            end
                j2=find(Aij(pos2,:));
                j2=is_coflict(pos2,j2,temp_Cij2,Z,Bii);% 在j2点pos2与其他是否冲突
             if ~isempty(j1)&&~isempty(j2)
                    j2=j2(ceil(rand(1)*length(j2)));
                temp_fitness2=calculate_fitness(pos1,j1,pos2,j2,data1,transfer_time);
                temp_fitness=temp_fitness+temp_fitness2;
                if sum(temp_Cij(pos1,:)==1)==0
                    temp_Cij(pos1,j1)=1;
                end
                if sum(temp_Cij(pos2,:)==1)==0
                    temp_Cij(pos2,j2)=1;
                end
             end
        end
    end
    %更新Cij
    if temp_fitness<fitness
        fitness=temp_fitness;
        Cij=temp_Cij;
    end
   disp(['第',num2str(iter),'迭代的结果为:',num2str(fitness)])
end 

Cij=assign_flight(Cij);%利用贪心算法求解

%% 输出
[a,b]=find(Cij==1);
result=[a,b];
b2=unique(b);
for i=1:length(a)
    disp(['第',num2str(a(i)),'航班分配给',num2str(b(i)),'登机口']);
end
disp(['一共',num2str(length(a)),'个航班被分配'])
disp(['一共',num2str(length(b2)),'个登机口被使用'])
