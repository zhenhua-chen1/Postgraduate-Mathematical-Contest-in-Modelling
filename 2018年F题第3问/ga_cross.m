function [ race_new ] = ga_cross( race,P_Cross )
% k=race(1,1);
% [m,n]=size(race);
% race=race(1:m,2:n-1);
[m,n]=size(race);
race_new=race;
for i=1:m-1
    flag=rand;
    if(flag<=P_Cross)
        list=randperm(n-1);
        Cross_Node=list(1);
        child=zeros(1,n);
        parent_1=race_new(i,:);
        parent_2=race_new(i+1,:);
        child(Cross_Node)=parent_2(Cross_Node);
        child(Cross_Node+1)=parent_2(Cross_Node+1);
        index_1=find(parent_1 == child(Cross_Node));
        index_2=find(parent_1 == child(Cross_Node+1));
        if(index_1>index_2)
            parent_1(index_1)=[];
            parent_1(index_2)=[];
        else
            parent_1(index_2)=[];
            parent_1(index_1)=[];
        end
        for j=1:n-2
            if(j<Cross_Node)
                child(j)=parent_1(j);
            end
            if(j>=Cross_Node)
                child(j+2)=parent_1(j);
            end
        end
        race_new(i,:)=child;
    end
end
% race_new=[k*ones(m,1),race_new,k*ones(m,1)];
end

