function fitness=ga_fitness2(Passenger_pop,w)
fitness=[];
for p=Passenger_pop'
    [temp_cij,temp_fitness]=func(p');
    Cij=assign_flight(temp_cij);%利用贪心算法求解
    [a,b]=find(Cij==1);
    b=unique(b);
    f=mapminmax([temp_fitness,length(a),length(b)],1,2);
    temp_fitness=w(1)*f(1)-w(2)*f(2)+w(3)*f(3);
    fitness=[fitness;temp_fitness];
end
end