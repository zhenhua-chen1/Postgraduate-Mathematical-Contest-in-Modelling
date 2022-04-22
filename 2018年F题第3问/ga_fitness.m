function fitness=ga_fitness(Passenger_pop)
fitness=[];
for p=Passenger_pop'
    [~,temp_fitness]=func(p');
    fitness=[fitness;temp_fitness];
end
end