function temp_fitness=calculate_fitness(pos1,j1,pos2,j2,data1,transfer_time,transfer_times,Direction,ta_i,td_i)
if (data1(pos1,4)==2)&&(j1<=28)&&(data1(pos2,9)==2)&&(j2<=28)
    temp_fitness=transfer_time(1,1)+transfer_times(1,1)*8;
    walk_time=get_walk(Direction(j1),0,Direction(j2),0);
    temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
elseif(data1(pos1,4)==2)&&(j1>28)&&(data1(pos2,9)==2)&&(j2<=28)
    temp_fitness=transfer_time(2,1)+transfer_times(1,1)*8;
    walk_time=get_walk(Direction(j1),1,Direction(j2),0);
    temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
elseif(data1(pos1,4)==2)&&(j1<=28)&&(data1(pos2,9)==2)&&(j2>28)
    temp_fitness=transfer_time(1,2)+transfer_times(1,1)*8;
    walk_time=get_walk(Direction(j1),0,Direction(j2),1);
    temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
elseif(data1(pos1,4)==2)&&(j1>28)&&(data1(pos2,9)==2)&&(j2>28)
    temp_fitness=transfer_time(2,2)+transfer_times(1,1)*8;
    walk_time=get_walk(Direction(j1),1,Direction(j2),1);
    temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
elseif (data1(pos1,4)==2)&&(j1<=28)&&(data1(pos2,9)==0)&&(j2<=28)
    temp_fitness=transfer_time(1,3)+transfer_times(1,1)*8;
    walk_time=get_walk(Direction(j1),0,Direction(j2),0);
    temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
elseif (data1(pos1,4)==2)&&(j1>28)&&(data1(pos2,9)==0)&&(j2<=28)
    temp_fitness=transfer_time(2,3)+transfer_times(1,1)*8;
    walk_time=get_walk(Direction(j1),1,Direction(j2),0);
    temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
elseif (data1(pos1,4)==2)&&(j1<=28)&&(data1(pos2,9)==0)&&(j2>28)
    temp_fitness=transfer_time(1,4)+transfer_times(1,1)*8;
    walk_time=get_walk(Direction(j1),0,Direction(j2),1);
    temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
elseif (data1(pos1,4)==2)&&(j1>28)&&(data1(pos2,9)==0)&&(j2>28)
    temp_fitness=transfer_time(2,4)+transfer_times(1,1)*8;
    walk_time=get_walk(Direction(j1),1,Direction(j2),1);
    temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
elseif (data1(pos1,4)==0)&&(j1<=28)&&(data1(pos2,9)==2)&&(j2<=28)
    temp_fitness=transfer_time(3,1)+transfer_times(1,1)*8;
    walk_time=get_walk(Direction(j1),0,Direction(j2),0);
    temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
elseif (data1(pos1,4)==0)&&(j1<=28)&&(data1(pos2,9)==2)&&(j2>28)
    temp_fitness=transfer_time(3,2)+transfer_times(1,1)*8;
    walk_time=get_walk(Direction(j1),0,Direction(j2),1);
    temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
elseif (data1(pos1,4)==0)&&(j1>28)&&(data1(pos2,9)==2)&&(j2<=28)
    temp_fitness=transfer_time(4,1)+transfer_times(1,1)*8;
    walk_time=get_walk(Direction(j1),1,Direction(j2),0);
    temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
elseif (data1(pos1,4)==0)&&(j1>28)&&(data1(pos2,9)==2)&&(j2>28)
    temp_fitness=transfer_time(4,2)+transfer_times(1,1)*8;
    walk_time=get_walk(Direction(j1),1,Direction(j2),1);
    temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
elseif (data1(pos1,4)==0)&&(j1<=28)&&(data1(pos2,9)==0)&&(j2<=28)
    temp_fitness=transfer_time(3,3)+transfer_times(1,1)*8;
    walk_time=get_walk(Direction(j1),0,Direction(j2),0);
    temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
elseif (data1(pos1,4)==0)&&(j1<=28)&&(data1(pos2,9)==0)&&(j2>28)
     temp_fitness=transfer_time(3,4)+transfer_times(1,1)*8;
     walk_time=get_walk(Direction(j1),0,Direction(j2),1);
     temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
 elseif (data1(pos1,4)==0)&&(j1>28)&&(data1(pos2,9)==0)&&(j2<=28)
     temp_fitness=transfer_time(4,3)+transfer_times(1,1)*8;
     walk_time=get_walk(Direction(j1),1,Direction(j2),0);
     temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
 elseif (data1(pos1,4)==0)&&(j1>28)&&(data1(pos2,9)==0)&&(j2>28)
     temp_fitness=transfer_time(4,4)+transfer_times(1,1)*8;
     walk_time=get_walk(Direction(j1),1,Direction(j2),1);
     temp_fitness=(temp_fitness+walk_time)/(td_i(pos2)-ta_i(pos1));
end
end