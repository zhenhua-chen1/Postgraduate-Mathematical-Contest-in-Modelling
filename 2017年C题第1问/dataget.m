function dataget()
    Schedules=readtable('Schedules1.xlsx');%load data
    Aircrafts=readtable('Aircrafts.xlsx');%load data
    No_Schedules=Schedules{:,1};
    No_Aircrafts=Aircrafts{:,1};
    n_f=97;%the number of flight
    n_a=16;%the number of aircrafts
    Aij1=ones(n_a,n_f);%Aircrafts i is assigned  flights j
    flights=Schedules{1:n_f,2:5};%the number of flights
    flights=[flights,zeros(length(flights),1)];
    for i=1:n_f
        air1=Schedules{i,7};
        air1=air1{1};
        for j=1:n_a
            air2=Aircrafts{j,1};
            air2=air2{1};
           if air1==air2
               Aij1(j,i)=0;
               flights(i,5)=j;
           end
        end
    end
    Aircrafts=Aircrafts{1:n_a,3:5};% the number of Aircrafts
    
    
    save data Aircrafts Schedules flights Aij1 No_Schedules No_Aircrafts
end