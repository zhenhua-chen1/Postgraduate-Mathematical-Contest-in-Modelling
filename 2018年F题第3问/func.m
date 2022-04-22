function [temp_Cij,temp_fitness]=func(Passenger2)
load data
Passenger=floor(Passenger2);
rand1=Passenger2-Passenger;
rand2=rand1*10-floor(rand1*10);
temp_Cij=zeros(Z,N);
temp_fitness=0;
for p=Passenger
    i1=data2(p,2);%arrive
    i2=data2(p,4);%depature
    pos1=find_pos(i1,date_a(p),data1(:,3),data1(:,16));%找到对应航班的索引；
    pos2=find_pos(i2,date_d(p),data1(:,8),data1(:,17));
    if ~isempty(pos1)&&~isempty(pos2)
        j1=find(Aij(pos1,:));%找到符合约束的登机口
        j1=is_coflict(pos1,j1,temp_Cij,Z,Bii);% 在j1点pos1与其他是否冲突
        if ~isempty(j1)
            j1=j1(ceil(rand1(p)*length(j1)));%随机选一个登机口
            if sum(temp_Cij(pos1,:)==1)==0
                temp_Cij2=temp_Cij;
                temp_Cij2(pos1,j1)=1;
            end
        end
        j2=find(Aij(pos2,:));
        j2=is_coflict(pos2,j2,temp_Cij2,Z,Bii);% 在j2点pos2与其他是否冲突
        if ~isempty(j1)&&~isempty(j2)
            j2=j2(ceil(rand2(p)*length(j2)));
            temp_fitness2=calculate_fitness(pos1,j1,pos2,j2,data1,transfer_time,transfer_times,Direction,ta_i,td_i);
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
end