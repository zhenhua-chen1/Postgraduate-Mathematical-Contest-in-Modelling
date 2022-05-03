clc
clear all
DataGet()
load data
pop_size=10;%种群规模
best_line=[];
%% 遗传算法数据
Iter_max=10;%最大迭代次数
w=[0.6,0.3,0.1];%适应性函数对应系数
cp=0.6; %交叉概率
mp=0.1;% 变异概率
tic

%% 编码和解码
for i=1:pop_size
    Passenger_pop(i,1:Passenger)=randperm(Passenger)+rand(1,Passenger);
end
% fitness= ga_fitness2(Passenger_pop,w);
fitness= ga_fitness(Passenger_pop);
best_fit=min(fitness);


%% 遗传算法求解
for t=1:Iter_max
    Passenger_pop2 = ga_choose( Passenger_pop,fitness );
    Passenger_pop2 = ga_cross( Passenger_pop2,cp);
    Passenger_pop2 = ga_mutation(Passenger_pop2 ,mp);
%     fitness2= ga_fitness2(Passenger_pop2,w);
    fitness2= ga_fitness(Passenger_pop2);
    best_fit2=min(fitness2);
    if best_fit2<best_fit
        fitness=fitness2;
        Passenger_pop=Passenger_pop2;
        best_fit=best_fit2;
    end
    best_line=[best_line,best_fit];
    disp(['第',num2str(t),'迭代结果为：',num2str(best_fit)]);
end

% 画图
plot(best_line);
xlabel('迭代次数');
ylabel('适应性函数');
title('遗传算法迭代图');
[~,pos]=min(fitness);
Passenger_pop=Passenger_pop(pos,:);
[Cij,best_tension]=func(Passenger_pop);
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
disp(['紧张度为：',num2str(best_tension)])
toc