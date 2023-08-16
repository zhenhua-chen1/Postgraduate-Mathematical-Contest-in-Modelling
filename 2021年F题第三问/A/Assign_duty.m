function [scheduleTable,time1,time2,time3,Rho,min_j,path,path_flight,i] = Assign_duty(time1,time2,time3,Rho,min_j,startnum,i,flightdata,path,path_flight,scheduleTable)
    Data_Flight_csv = readtable('机组排班Data A-Flight.csv');
    MaxDP = 720; %最大执勤时间
    MinRest = 660; %最小飞行时间
    MaxBlk = 600;
    if nargin < 11
        scheduleTable = [];
    end
    for j=min_j
        if i<j&&Rho(i,j)==1
            if (flightdata(j,14)-time1)*24*60<=MaxDP&&flightdata(j,8)==time2&&(time3+(flightdata(j,13)-flightdata(j,9)))*24*60<=MaxBlk  
                path=[path,j];
                path_flight = [path_flight,Data_Flight_csv{j,1}];
                % renew the time of flight and the next flight
                time3=time3+(flightdata(j,14)-flightdata(j,10));
                i=j;
                min_j=find(Rho(i,:)==1);
            elseif flightdata(j,10)>time2&&(flightdata(j,10)-flightdata(i,14))*24*60>MinRest
                if length(path) == 1
                    scheduleTable =1;
                    return
                end
                time_end=flightdata(i,14);%renew the end time
                if time3 == 0
                    time3 = time3+(flightdata(i,14)-flightdata(i,10));
                end
%                         if (time_end-time1)*24*60<100
%                             scheduleTable =1;
%                             path = o;
%                             return
%                         end
                i=j;
                min_j=find(Rho(i,:)==1);
                pos = find(path==startnum);
                scheduleTable(k,:) = table(Data_Flight_csv{path(pos),3}, Data_Flight_csv{path(pos),2}, time3*24*60, (time_end-time1)*24*60,Data_Flight_csv{path(end),6}, {path_flight(pos:end)}, Data_Flight_csv{path(pos),4}, Data_Flight_csv{path(end),7},{path(pos:end)},EmpNo,'VariableNames', {'Time_start', 'Day_start', 'Time_flight', 'Time_duty','Time_end', 'Flight_num','DptrStn_duty','ArrvStn_duty','path','EmpNo'});
                path=[path,j];
                path_flight = [path_flight,Data_Flight_csv{j,1}];
                k=k+1;
                time1=flightdata(j,10); %renew the start time
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
end