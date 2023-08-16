function output_flight(path_all1,path_all2,I2)
    load path12
    [a1,b]=size(path_all1);
    [a2,b]=size(path_all2);
    rawA = readcell('机组排班Data B-Flight1.xlsx');
    % Convert the 4rd and 7th columns to HH:MM format
    rawA(2:end, 4) = cellfun(@(x) datestr(datenum(0, 0, 0, x*24, 0, 0), 'HH:MM'), rawA(2:end, 4), 'UniformOutput', false);
    rawA(2:end, 7) = cellfun(@(x) datestr(datenum(0, 0, 0, x*24, 0, 0), 'HH:MM'), rawA(2:end, 7), 'UniformOutput', false);
    rawB = readcell('机组排班Data B-Crew.csv');
    twt={'员工号','航段次序','航班号','出发日期','出发时间','出发机场','到达日期','到达时间','到达机场','实际资格'};
    twt2={'航班号','出发日期','出发时间','出发机场','到达日期','到达时间','到达机场','最低配置要求'};
    temp_raw=rawB;

    %% 第一个环
    for p=1:a1
        for  C=2:length(temp_raw)
           if temp_raw{C,2}==1
              Captain=temp_raw{C,1};%选主飞
              temp_raw(C,:)=[];
              break
           end
        end
        for  F=2:length(temp_raw)
           if (temp_raw{F,2}==0)&&(temp_raw{F,3}==1)
              FirstOfficer=temp_raw{F,1};%选副飞
              temp_raw(F,:)=[];
              break
           end
        end
          temp_path=path_all1(p,:);
          temp_path(find(path_all1(p,:)==0))=[];
          for i=1:length(temp_path)
              path=temp_path(i);
              twt=[twt;{Captain,i,rawA{path+1,2:end-1},'C'}];
              twt=[twt;{FirstOfficer,i,rawA{path+1,2:end-1},'F'}];
          end
    end
    %% 第二个环
    for p=1:a2
        for  C=2:length(temp_raw)
           if temp_raw{C,2}==1
              Captain=temp_raw{C,1};%选主飞
              temp_raw(C,:)=[];
              break
           end
        end
        for  F=2:length(temp_raw)
           if (temp_raw{F,2}==0)&&(temp_raw{F,3}==1)
              FirstOfficer=temp_raw{F,1};%选副飞
              temp_raw(F,:)=[];
              break
           end
        end
          temp_path=path_all2(p,:);
          temp_path(find(path_all2(p,:)==0))=[];
          for i=1:length(temp_path)
              path=temp_path(i);
              twt=[twt;{Captain,i,rawA{path+1,2:end-1},'C'}];
              twt=[twt;{FirstOfficer,i,rawA{path+1,2:end-1},'F'}];
          end
    end 
    for i=I2
        twt2=[twt2;{rawA{i+1,2:end}}];
    end
     writecell(twt,'CrewRosters.xls')
     writecell(twt2,'UncoveredFlights.xls')
     % Remove rows where 'Time_flight' is negative
     scheduleTables(scheduleTables.Time_flight < 0, :) = [];
     writetable(scheduleTables,'scheduleTables.csv')
end