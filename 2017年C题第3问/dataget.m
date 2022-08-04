function dataget()
    dbstop if error
    %load data
    Schedules=readtable('Schedules1.xlsx');
    Aircrafts=readtable('Aircrafts2.xlsx');%load data
    No_Aircrafts=readtable('Aircrafts2.xlsx');%load data
    No_Schedules2=readtable('Schedules.xlsx');
    No_Aircrafts2=readtable('副本Aircrafts.xlsx');%load data
    [~,~,Schedules2]=xlsread('Schedules1.xlsx');%load data
    [~,~,Aircrafts2]=xlsread('Aircrafts.xlsx');%load data
    Paxinfo=readtable('Paxinfo.xlsx');
    
    air_decode1=Schedules2(2:end,4);
    air_decode2=Schedules2(2:end,5);
    air_decode3=Aircrafts2(2:end,5);
    [air_decode1,air_decode2,air_decode3]=decode_air(air_decode1,air_decode2,air_decode3);
    Schedules{:,4}=air_decode1;
    Schedules{:,5}=air_decode2;
    Aircrafts{:,5}=air_decode3;
    No_Schedules=Schedules(:,[1,6]);
    No_Aircrafts=No_Aircrafts(:,[1,2]);
    [n_f,~]=size(No_Schedules);%the number of flight
    [n_a,~]=size(No_Aircrafts);%the number of aircrafts
    Aij1=ones(n_a,n_f);%Aircrafts i is assigned  flights j
    Aircrafts=Aircrafts{: ,3:6};% the number of Aircrafts
    flights=Schedules{:,2:5};%the number of flights
    flights=[flights,zeros(length(flights),2)];

    
    for i=1:n_f
        air1=Schedules{i,7}{1};
        for j=1:n_a
            air2=No_Aircrafts{j,1}{1};
           if air1==air2
               Aij1(j,i)=0;
               flights(i,5)=j;
           end
        end
    end
    
    Paxinfo_temp=Paxinfo{:,2};
    for i=1:height(Schedules)
        P_num=Schedules{i,1};
        pos=find(Paxinfo_temp==P_num);
        flights(i,6)=sum(Paxinfo{pos,3});
    end

    delay_stime=1461348000;
    delay_etime=1461358800;
    type_Schedules=No_Schedules{:,2} ;
    type_Aircrafts=No_Aircrafts{:,2} ;
    No_Aircrafts=No_Aircrafts2(:,[1,2]);
    No_Schedules=No_Schedules2(:,[1,6]);
    
    save data Aircrafts Schedules flights Aij1 No_Schedules No_Aircrafts type_Schedules  type_Aircrafts
end

function [air_decode1,air_decode2,air_decode3]=decode_air(air_decode1,air_decode2,air_decode3)
    count=0;
    for i=1:length(air_decode2)
        if isstr(air_decode2{i})
            a=air_decode2{i};
            count=count+1;
            pos1=find_pos(a,air_decode1);
            pos2=find_pos(a,air_decode2);
            pos3=find_pos(a,air_decode3);
            for p=pos1'
                air_decode1{p}=count+25; 
            end
            for p=pos2'
                air_decode2{p}=count+25; 
            end
            for p=pos3'
                air_decode3{p}=count+25; 
            end
        end
    end
  air_decode1=cell2mat(air_decode1);  
  air_decode2=cell2mat(air_decode2);  
  air_decode3{31}=8;
  air_decode3=cell2mat(air_decode3);
end
function pos=find_pos(a,air_decode1)
    pos=[];
    for i=1:length(air_decode1)
        if a == air_decode1{i}
            pos=[pos;i];
        end
    end
end