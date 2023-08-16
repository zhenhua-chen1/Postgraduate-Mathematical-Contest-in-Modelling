function [path, scheduleTable] = PathGenerate1(Rho2, o)
    load data;
    Data_Flight_csv = readtable('机组排班Data A-Flight.csv');
    flightdata = dataA_Flight;
    Rho = Rho2;

    currentFlightTime = flightdata(o, 10);
    startTime = flightdata(o, 8);
    startFlightNumber = o;

    path = o;
    path_flight = Data_Flight_csv{o, 1};
    current_j = find(Rho(o, :) == 1);
    scheduleTable = table();

    while o ~= I
        % 执勤开始航班o
        if ~isempty(current_j)
            for j = current_j
                % 检查时间和航班条件
                if checkTimeAndFlightCondition(flightdata, j, currentFlightTime, startTime, MaxDP, MaxBlk)
                    % 更新路径和时间
                    path = [path, j];
                    path_flight = [path_flight, Data_Flight_csv{j, 1}];
                    currentFlightTime = updateFlightTime(flightdata, j);
                    o = j;
                    current_j = find(Rho(o, :) == 1);
                elseif  checkDutyRestCondition(flightdata, j, i, MinRest)
                        % 将当前执勤记录下来
                        % 记录结束时间
                        time_end = flightdata(i,14);
                        % 更新总执勤时间
                        if time3 == 0
                            time3 = time3 + (flightdata(i,14) - flightdata(i,10));
                        end
                        
                        % 创建表格并记录执勤信息
                        temp_scheduleTable = table(Data_Flight_csv{path(pos),3}, Data_Flight_csv{path(pos),2}, time3*24*60, (time_end-time1)*24*60, Data_Flight_csv{path(end),6}, {path_flight(pos:end)}, Data_Flight_csv{path(pos),4}, Data_Flight_csv{path(end),7}, {path(pos:end)}, 'VariableNames', {'Time_start', 'Day_start', 'Time_flight', 'Time_duty','Time_end', 'Flight_num','DptrStn_duty','ArrvStn_duty','node'});
                        scheduleTable(k,:) = temp_scheduleTable;
                        scheduleTable1 = [scheduleTable1; temp_scheduleTable];

                        % 更新执勤信息
                end
            end
        end
    end

    % 更多的代码...
end

function valid = checkTimeAndFlightCondition(flightdata, j, currentFlightTime, startTime, MaxDP, MaxBlk)
    % 检查与时间和航班相关的条件
    % 返回一个逻辑值，表示条件是否满足

    timeDifference = (flightdata(j,14) - startTime) * 24 * 60;
    flightDay = flightdata(j,8);
    nextFlightTime = (flightdata(j,13) - flightdata(j,9)) * 24 * 60;

    % 条件1：与开始时间的差异不能超过MaxDP
    condition1 = timeDifference <= MaxDP;

    % 条件2：航班的时间必须等于给定的currentFlightTime
    condition2 = flightdata(j,8) == currentFlightTime;

    % 条件3：当前航班时间加上下一个航班时间不能超过MaxBlk
    condition3 = (currentFlightTime + nextFlightTime) <= MaxBlk;

    % 所有条件必须满足
    valid = condition1 && condition2 && condition3;
end

function valid = checkDutyRestCondition(flightdata, j, i, MinRest)
    % 检查与执勤之间的休息时间相关的条件
    % 返回一个逻辑值，表示条件是否满足

    % 计算执勤i和j之间的休息时间（例如，可以根据上一次执勤的结束时间和下一次执勤的开始时间计算）
    restTime = (flightdata(j,10) - flightdata(i,14)) * 24 * 60;

    % 获取上一次执勤的结束日期和下一次执勤的开始日期
    endDatePreviousDuty = floor(flightdata(i,14));
    startDateNextDuty = floor(flightdata(j,10));

    % 条件：休息时间必须大于等于MinRest，且下一次执勤时间和上一次执勤时间不能在同一天
    valid = (restTime >= MinRest) && (startDateNextDuty > endDatePreviousDuty);
end


function updatedTime = updateFlightTime(flightdata, j)
    % 根据飞行数据更新当前的飞行时间
    % ...
end
