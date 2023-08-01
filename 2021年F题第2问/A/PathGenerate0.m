function [path,scheduleTable]=PathGenerate0(Rho2,o,~)
    load data
    Data_Flight_csv = readtable('机组排班Data A-Flight.csv');
    %The total duration of the task loop for a single crew member in the scheduling cycle will not exceed
    flightdata=dataA_Flight;
    Rho=Rho2;
    time3=0;%the filght time on duty
    time2=flightdata(o,8);
    time1=flightdata(o,10);
    startnum=o; %the filght number on duty
    k=1;%the number of duty
    i=o;
    step=1;
    path(1)=o;
    path_flight = Data_Flight_csv{o,1};
    min_j=find(Rho(o,:)==1);
    while i~=I&&step<=I
    %执勤开始航班i
        for j=min_j
            if i<j&&Rho(i,j)==1
                if (flightdata(j,14)-time1)*24*60<=MaxDP&&flightdata(j,8)==time2&&(time3+(flightdata(j,13)-flightdata(j,9)))*24*60<=MaxBlk  
                    path=[path,j];
                    path_flight = [path_flight,Data_Flight_csv{j,1}];
                    % renew the time of flight and the next flight
                    time3=time3+(flightdata(j,13)-flightdata(j,9));
                    i=j;
                    min_j=find(Rho(i,:)==1);
                elseif flightdata(j,10)>time2&&(flightdata(j,10)-flightdata(i,14))*24*60>MinRest 
                    
                    time_end=flightdata(i,14);%renew the end time
                    i=j;
                    min_j=find(Rho(i,:)==1);
                    pos = find(path==startnum);
                    scheduleTable(k,:) = table(Data_Flight_csv{path(pos),3}, Data_Flight_csv{path(pos),2}, time3*24*60, (time_end-time1)*24*60,Data_Flight_csv{path(end),6}, {path_flight(pos:end)},  'VariableNames', {'Time_start', 'Day_start', 'Time_flight', 'Time_duty','Time_end', 'Flight_num'});
                    path=[path,j];
                    path_flight = [path_flight,Data_Flight_csv{j,1}];
                    k=k+1;
                    time1=flightdata(j,14); %renew the start time
                    time2=flightdata(j,8); %renew the start day
                    startnum=j;
                     % Save the variables into a table
                    time3=0;
                    break
                else
                    continue
                end
            end
        end
      step=step+1;  
    end
    [~,b]=size(path);
    time_end(k)=flightdata(path(b),4);
    if sum(path)==o
        scheduleTable = 1;
    end
    
end 