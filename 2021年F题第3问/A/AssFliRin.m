clc
clear all
load path12

% 读取数据
No = 1;
scheduleTables_i = scheduleTables(scheduleTables.EmpNo == 1, :);
I = height(scheduleTables_i);
MaxTAFB = 14400;%执勤最大时长
Time_dute_all = 0;
Time_dute = 0;
Time_day = 0;
k = 1;
i = 1;
Dpt_stn = scheduleTables_i.DptrStn_duty(1);%离开机场
Dpt_Day = scheduleTables_i.Day_start(1);%离开时间
while i <=I
    if  Time_dute_all + scheduleTables_i.Time_duty(i) <= MaxTAFB 
        Time_dute_all = Time_dute_all + scheduleTables_i.Time_duty(i);
        if  Time_day + 1 <=4
            if i ~= I && mod(i,3)~=0 %选三个执勤
                Time_dute = Time_dute + scheduleTables_i.Time_duty(i);
                i = i+1;
                Time_day = Time_day + 1;
            %判断循环是否结束
            elseif i == I && mod(i,3)~=0
                    Time_dute = Time_dute + scheduleTables_i.Time_duty(i);
                    Arr_stn = scheduleTables_i.ArrvStn_duty(i);%达到机场
                    Arr_Day = scheduleTables_i.Day_start(i);%达到时间
                    ringTable(k,:) = table(Time_dute, Dpt_stn,Arr_stn,Dpt_Day,Arr_Day,'VariableNames', ...
                        {'ring_time','Dpt_stn','Arr_stn','Dpt_Day','Arr_Day'});
                    break
            else
                %判断是否选第4个执勤加入任务环
                if scheduleTables_i.Time_duty(i) < scheduleTables_i.Time_duty(i+1)
                    Time_dute = Time_dute + scheduleTables_i.Time_duty(i)+scheduleTables_i.Time_duty(i+1);
                    Arr_stn = scheduleTables_i.ArrvStn_duty(i+1);%达到机场
                    Arr_Day = scheduleTables_i.Day_start(i+1);%达到时间
                    ringTable(k,:) = table(Time_dute, Dpt_stn,Arr_stn,Dpt_Day,Arr_Day,'VariableNames', ...
                        {'ring_time','Dpt_stn','Arr_stn','Dpt_Day','Arr_Day'});
                    i = i+3;
                    Time_day = 0;
                    Dpt_stn = scheduleTables_i.DptrStn_duty(i);%离开机场
                    Dpt_Day = scheduleTables_i.Day_start(i);
                    %如果达到机场和离开机场不一样需修正
                    if Dpt_stn{1} ~= Arr_stn{1}
                        scheduleTables_i(i,:) = revised_schedule(scheduleTables_i(i,:),Arr_stn{1});
                    end
                    k = k + 1;
                else
                    Time_dute = Time_dute + scheduleTables_i.Time_duty(i);
                    Arr_stn = scheduleTables_i.ArrvStn_duty(i);%达到机场
                    Arr_Day = scheduleTables_i.Day_start(i);%达到时间
                    ringTable(k,:) = table(Time_dute, Dpt_stn,Arr_stn,Dpt_Day,Arr_Day,'VariableNames', ...
                        {'ring_time','Dpt_stn','Arr_stn','Dpt_Day','Arr_Day'});
                    Time_day = 0;
                    i = i+2;
                    Dpt_stn = scheduleTables_i.DptrStn_duty(i);%离开机场
                    Dpt_Day = scheduleTables_i.Day_start(i);
                    k = k +1 ;
                end
            end
        end
    else
        break
    end
end
