function [pos,Aij]=find_pos2(n,N_f,n_arrive_time,port_arrive_time,Aij)
    load data
    assign_i=prod(Aij);
    pos=find((flights(:,3)==N_f).*(flights(:,2)<=n_arrive_time).*(flights(:,1)>=port_arrive_time/60+45).*assign_i');
    pos_one=randperm(length(pos));
    if ~isempty(pos)
        pos=pos(pos_one(1));%select one flight
    end
    Aij(n,pos)=0; 
end