clc
clear all
% DataGet()
load data
fitness=inf;% fitness£¨transfer time£©
Iter_max=100;% Maximum number of iterations
for iter=1:Iter_max
    temp_Cij=zeros(Z,N);
    temp_fitness=0;
    for p=1:Passenger
        i1=data2(p,2);
        i2=data2(p,4);
        pos1=find_pos(i1,date_a(p),data1(:,3),data1(:,16));% Find the index of the corresponding flight.
        pos2=find_pos(i2,date_d(p),data1(:,8),data1(:,17));
        if ~isempty(pos1)&&~isempty(pos2)
                j1=find(Aij(pos1,:));% Find a gate that satisfies the constraints
                j1=is_coflict(pos1,j1,temp_Cij,Z,Bii);% Is pos1 at j1 in conflict with other
            if ~isempty(j1)
                j1=j1(ceil(rand(1)*length(j1)));% Randomly select a gate
                if sum(temp_Cij(pos1,:)==1)==0
                    temp_Cij2=temp_Cij;
                    temp_Cij2(pos1,j1)=1;
                end
            end
                j2=find(Aij(pos2,:));
                j2=is_coflict(pos2,j2,temp_Cij2,Z,Bii);% Is pos2 at j2 in conflict with other
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
    % renew the Cij
    if temp_fitness<fitness
        fitness=temp_fitness;
        Cij=temp_Cij;
    end
   disp(['the No.',num2str(iter),' iteration results in: ',num2str(fitness)])
end 

Cij=assign_flight(Cij);% call the Greedy algorithm

%% output
[a,b]=find(Cij==1);
result=[a,b];
b2=unique(b);
for i=1:length(a)
    disp(['the No.',num2str(a(i)),' flight is assigned the No.',num2str(b(i)),' gate']);
end
disp(['There are ',num2str(length(a)),' flights assigned in total'])
disp(['There are ',num2str(length(b2)),' gates used in total'])

