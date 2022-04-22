function [ race_new ] = ga_choose( race,adaptation )
    [m,n]=size(race);
    race_new=zeros(m,n);
    competition_number=floor(m/10);
    for i=1:m
        competition=zeros(1,competition_number);
        temp=randperm(m);
        for j=1:competition_number
            competition(1,j)=adaptation(temp(j));
        end
        [val,index]=min(competition);
        race_new(i,:)=race(temp(index),:);
    end
end

