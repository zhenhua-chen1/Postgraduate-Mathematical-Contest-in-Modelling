function [path,scheduleTable,ParingTables]=PathGenerate0(Rho2,o,EmpNo)
    load data
    Data_Flight_csv = readtable('机组排班Data B-Flight.xlsx');
    %The total duration of the task loop for a single crew member in the scheduling cycle will not exceed
    flightdata=dataB_Flight;
    Rho=Rho2;
    time3=0;%the filght time on duty
    day_start=flightdata(o,7);%the start day on duty
    time_start=flightdata(o,10);%the start time on duty
    pairingStartDay = day_start;% the start day on pairing
    pairingStartFlight = o;% the start flight on pairing
    startnum=o; %the filght number on duty
    allPairingTime = 0; %the pairing Time
    PairingTime = 0;
    k=1;%the number of duty
    i=o;
    step=1;
    path(1)=o;
    path_flight = Data_Flight_csv{o,1};
    min_j=find(Rho(o,:)==1);
    scheduleTable = table();
    ParingTables = table();
    duty_start = {};
    flag = 1;
    while i~=I&&step<=I
        if ~isempty(min_j)
            % At least MinVacDay between two adjacent task rings
            idx = 1;
            while idx <= length(min_j)
                day_start=flightdata(i,8);%the start day on duty
                time_start=flightdata(i,10);%the start time on duty
                startnum = i;
   
                % the start duty on flight i
                [path, path_flight, time_start, day_start, time3, i, min_j, temp_scheduleTable, flag] = ...
                    handleDuty(i, path, path_flight, Rho, flightdata, Data_Flight_csv, ...
                               time_start, day_start, time3, startnum,  MaxDP, MaxBlk, MinRest,flag,EmpNo);
                if length(path) == 1
                    scheduleTable = 1;
                    return;
                end
%               if length(temp_scheduleTable.Flight_num{1})~=1
                if ~isempty(temp_scheduleTable)
                    % check the total Pair not excuess the MaxTAFB
                    allPairingTime = allPairingTime + temp_scheduleTable.Time_duty;
                    if allPairingTime > MaxTAFB
                            return
                    end
                    scheduleTable = [scheduleTable;temp_scheduleTable]; 
                    % Update the data for the  Pairing and next Duty
                     day_end = flightdata(path(end),8);
                     pairingStartFlightPrev = pairingStartFlight;
                     pairingStartDayPrev = pairingStartDay;
                     [i,min_j,pairingStartDay,pairingStartFlight]  = checkSatisJ(min_j,  flightdata,pairingStartDay,Rho,day_end,pairingStartFlight,MaxSuccOn);
                     % Update the data for the  Pairing  data
                     PairingTime = PairingTime + temp_scheduleTable.Time_duty;
                     if i~=0
                         if  pairingStartFlight~=pairingStartFlightPrev
                             ParingTables = savePairingData(scheduleTable, Data_Flight_csv, pairingStartFlightPrev, path, ...
                             path_flight, ParingTables,PairingTime,EmpNo);
                             PairingTime = 0;
                         end
                     end
                end
            end
        end
      step=step+1;  
    end
    if sum(path)==o
        scheduleTable = 1;
        ParingTables = 1;
        return
    end
        %renew the last Pairing Time
    ParingTables = savePairingData(scheduleTable, Data_Flight_csv, pairingStartFlightPrev, path, ...
                         path_flight, ParingTables,PairingTime,EmpNo);
    
end 



function [path, path_flight, time1, time2, time3, i, min_j, temp_scheduleTable,flag] = handleDuty(i, path, path_flight, Rho, flightdata, Data_Flight_csv, time1, time2, time3, startnum, MaxDP, MaxBlk, MinRest,flag,EmpNo)
    dbstop if error
    if flag ~= 1
        path = [path, i];
        path_flight = [path_flight, Data_Flight_csv{i,1}];
    end
    isFindPath = 0;
    flag = 0;
    min_j = find(Rho(i,:) == 1);
    idx = 1; % Use an index variable to track the position in min_j
    while idx <= length(min_j)
        j = min_j(idx);
        if i < j && Rho(i,j) == 1
            if (flightdata(j,14)-time1)*24*60 <= MaxDP && flightdata(j,8) == time2 && (time3 + (flightdata(j,13)-flightdata(j,9))) * 24*60 <= MaxBlk  
                path = [path, j];
                path_flight = [path_flight, Data_Flight_csv{j,1}];
                % renew the time of flight and the next flight
                time3 = time3 + (flightdata(j,14) - flightdata(j,10));
                [min_j, idx,i] = updateMinJandIdx(i, j, Rho);
            elseif flightdata(j,10) > time2 && (flightdata(j,10) - flightdata(i,14)) * 24*60 > MinRest
                if length(path) == 1
                    temp_scheduleTable = 1;
                    return;
                end
                time_end = flightdata(i,14); %renew the end time
                if time3 == 0
                    time3 = time3 + (flightdata(i,14) - flightdata(i,10));
                end
                %[min_j, idx,i] = updateMinJandIdx(i, j, Rho);
                pos_start_duty = find(path == startnum); % 找到当前执勤的开始位置
                try
                    temp_scheduleTable = table(Data_Flight_csv{path(pos_start_duty),3}, Data_Flight_csv{path(pos_start_duty),2}, time3*24*60, (time_end-time1)*24*60, Data_Flight_csv{path(end),6}, {path_flight(pos_start_duty:end)}, Data_Flight_csv{path(pos_start_duty),4}, Data_Flight_csv{path(end),7}, {path(pos_start_duty:end)}, EmpNo,'VariableNames', {'Time_start', 'Day_start', 'Time_flight', 'Time_duty', 'Time_end', 'Flight_num', 'DptrStn_duty', 'ArrvStn_duty', 'node','EmpNo'});
                catch exception
                    disp('Error occurred while creating the table:');
                    disp(exception.message);
                    keyboard;  % Pauses execution and gives control to the user. You can inspect
                end
                isFindPath = 1;
                time3 = 0;
                break;
            else
                idx = idx +1;
            end  
        end
    end
    if ~isFindPath
        temp_scheduleTable = [];
    end
end

function [min_j, idx,i] = updateMinJandIdx(i, j, Rho)
    if i ~= j
        i = j ;
        min_j = find(Rho(i,:) == 1);
        idx = 1; % Reset the index variable
    else
        idx = idx + 1; % Move to the next element
    end
end

function [i,min_j,pairingStartDay,pairingStartFlight] = checkSatisJ(min_j, flightdata,pairingStartDay,Rho,day_end,pairingStartFlight,MaxSuccOn)
    idx = 1;
    j = min_j(idx);
%     i = j;
%     min_j = find(Rho(i,:) == 1);
    for j = min_j
        next_day = flightdata(j,8); %renew the start day
        % No more than MaxSuccOn days
        if next_day - pairingStartDay< MaxSuccOn
            i = j;
            min_j = find(Rho(i,:) == 1);
            return 
        elseif next_day - day_end>1
            i = j;
            min_j = find(Rho(i,:) == 1);
            pairingStartDay = flightdata(i,7);%the start day on Pairing
            pairingStartFlight = i;
            return
        end
    end
    i = 0;
    min_j = [];
end

function ParingTables = savePairingData(scheduleTable, Data_Flight_csv, pairingStartFlightPrev, path, path_flight, ParingTables,PairingTime,EmpNo)
    % Extract the last duty start day from scheduleTable
    lastDutyStartDay = scheduleTable.Day_start(end);

    % Find the position based on the path
    temp_pos = find(pairingStartFlightPrev == path);

    % Extract the relevant flights and nodes
    PairingFlight = path_flight(temp_pos:end);
    node = path(temp_pos:end);

    % Create a table to save the pairing data
    %PairingTime = sum([Data_Flight_csv{node, 5}]); % This is a placeholder, you might need to adjust the column index or calculation method to correctly compute PairingTime based on your data
    try
        ParingTable = table(Data_Flight_csv{pairingStartFlightPrev,2}, lastDutyStartDay, PairingTime, {PairingFlight}, {node}, EmpNo,'VariableNames', {'firstDutyStartDay','lastDutyStartDay','Pairing_time','PairingFlight','node','EmpNo'});
    catch exception
        disp('Error occurred while creating the table:');
        disp(exception.message);
        keyboard;  % Pauses execution and gives control to the user. You can inspect
    end
    % Append the new table to the existing one
    ParingTables = [ParingTables; ParingTable];
end

