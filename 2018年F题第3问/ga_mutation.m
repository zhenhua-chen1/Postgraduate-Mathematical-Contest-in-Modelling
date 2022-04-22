function [ race_new ] = ga_mutation( race,P_Mutation )
[m,n]=size(race);
race_new=race;
for i=1:m
    flag=rand;
    if(flag<=P_Mutation)
        race_new(i,:)=randperm(n)+rand(1,n);
    end
end
end

