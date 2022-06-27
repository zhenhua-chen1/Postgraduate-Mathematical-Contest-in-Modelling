function [pos,Aij]=find_pos1(n,N_f,Departure_time,arrive_time,Aij)
    load data
    assign_i=prod(Aij);
    pos=find((flights(:,3)==N_f).*(flights(:,1)>=Departure_time).*(flights(:,1)<=arrive_time).*assign_i');
    pos_one=randperm(length(pos));
    if ~isempty(pos)
        pos=pos(pos_one(1));%select one flight
    end
    Aij(n,pos)=0; 
end