function temp_fitness=calculate_fitness(pos1,j1,pos2,j2,data1,transfer_time)
if (data1(pos1,4)==2)&&(j1<=28)&&(data1(pos2,9)==2)&&(j2<=28)
    temp_fitness=transfer_time(1,1);
elseif(data1(pos1,4)==2)&&(j1>28)&&(data1(pos2,9)==2)&&(j2<=28)
    temp_fitness=transfer_time(2,1);
elseif(data1(pos1,4)==2)&&(j1<=28)&&(data1(pos2,9)==2)&&(j2>28)
    temp_fitness=transfer_time(1,2);
elseif(data1(pos1,4)==2)&&(j1>28)&&(data1(pos2,9)==2)&&(j2>28)
    temp_fitness=transfer_time(2,2);
elseif (data1(pos1,4)==2)&&(j1<=28)&&(data1(pos2,9)==0)&&(j2<=28)
    temp_fitness=transfer_time(1,3);
elseif (data1(pos1,4)==2)&&(j1>28)&&(data1(pos2,9)==0)&&(j2<=28)
    temp_fitness=transfer_time(2,3);
elseif (data1(pos1,4)==2)&&(j1<=28)&&(data1(pos2,9)==0)&&(j2>28)
    temp_fitness=transfer_time(1,4);
elseif (data1(pos1,4)==2)&&(j1>28)&&(data1(pos2,9)==0)&&(j2>28)
    temp_fitness=transfer_time(2,4);
elseif (data1(pos1,4)==0)&&(j1<=28)&&(data1(pos2,9)==2)&&(j2<=28)
    temp_fitness=transfer_time(3,1);
elseif (data1(pos1,4)==0)&&(j1<=28)&&(data1(pos2,9)==2)&&(j2>28)
    temp_fitness=transfer_time(3,2);
elseif (data1(pos1,4)==0)&&(j1>28)&&(data1(pos2,9)==2)&&(j2<=28)
    temp_fitness=transfer_time(4,1);
elseif (data1(pos1,4)==0)&&(j1>28)&&(data1(pos2,9)==2)&&(j2>28)
    temp_fitness=transfer_time(4,2);
elseif (data1(pos1,4)==0)&&(j1<=28)&&(data1(pos2,9)==0)&&(j2<=28)
    temp_fitness=transfer_time(3,3);
elseif (data1(pos1,4)==0)&&(j1<=28)&&(data1(pos2,9)==0)&&(j2>28)
     temp_fitness=transfer_time(3,4);
 elseif (data1(pos1,4)==0)&&(j1>28)&&(data1(pos2,9)==0)&&(j2<=28)
     temp_fitness=transfer_time(4,3);
 elseif (data1(pos1,4)==0)&&(j1>28)&&(data1(pos2,9)==0)&&(j2>28)
     temp_fitness=transfer_time(4,4);
end
end