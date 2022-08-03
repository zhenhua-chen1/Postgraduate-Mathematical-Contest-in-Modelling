clc
clear 
close all
dbstop if error
%dataget()
load data
[fitness,time]=get_delay_time(Aij1);
delay_time1=fitness/3600;
flight_alt=find_replace(time);
tic
for f=flight_alt
    disp(['start to change the fight ',num2str(No_Schedules{f,1})])
    flights2=flights;
    % find the flight can be switch
    pos=find((flights2(:,4)==flights2(f,3)).*...
        (flights2(:,2)+60*45<=flights2(f,1)).*...
        ((flights2(:,5)~=flights2(f,5))==1));
    % start to switch
    for p=pos'
        air1=flights2(p,5);
        pos2=find(flights2(:,5)==air1);
        pos2(1)=[];
        air2=flights2(f,5);
        pos3=find(flights2(:,5)==air2);
        po3_start=find(pos3==f);
        pos3=pos3(po3_start:end);
        %judge the the latest time
        if (~isempty(pos2))&&(~isempty(pos3))
            if flights2(pos2(end),2)<=Aircrafts(air2,2)&&...
                    flights2(pos2(1),1)>=Aircrafts(air2,1)&&...
                    flights2(pos3(end),2)<=Aircrafts(air1,2)&&...
                    flights2(pos3(1),1)>=Aircrafts(air1,1)
                temp_flight=flights2;
                temp_flight(pos3,5)=air1;
                temp_flight(pos2,5)=air2;
                Aij=flight2Aij(temp_flight);
                fitness2=get_delay_time(Aij);
                if fitness>fitness2
                    fitness=fitness2;
                    Aij1=Aij;
                    flights=temp_flight;
                end
            else
                continue
            end
        end
    end
end
[fitness,time,c]=get_delay_time(Aij1);
delay_time2=fitness/3600;

% output
aircrafts=cell(length(flights(:,5)),1);
aircrafts_type=cell(length(flights(:,5)),1);
delay_time=zeros(length(flights(:,5)),1);
for f=1:length(flights(:,5))
    aircrafts{f}=No_Aircrafts{flights(f,5),1};
    aircrafts_type{f}=No_Aircrafts{flights(f,5),2};
end
Schedules=No_Schedules{1:length(flights(:,5)),1};
Schedules_type=No_Schedules{1:length(flights(:,5)),2};
for i=1:length(delay_time)
    delay_time(i) = time(flights(i,5),i);
end
T = table(Schedules,Schedules_type,aircrafts,aircrafts_type,delay_time);
writetable(T,'第二问新航班表.xlsx');

for i=1:length(Aircrafts)
    for j=1:length(flights)
        if Aij1(i,j)==0
            if time(i,j)~=0
               air1= No_Aircrafts{i,1}{1};
               flight1= No_Schedules{j,1};
               delay_time=time(i,j);
                disp(['No. ', air1 ,' aircraft was assigned to flight No. ' ,num2str(flight1) ,' with a delay of ', num2str(delay_time),'s'])
            end
        end
    end
end
disp(['Delay time reduced from ',num2str(delay_time1), 'h to ',num2str(delay_time2),'h'])
toc