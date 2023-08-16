clc
clear 
close all
disp('读取数据')
dbstop if error
Dataget()
load data
tic
%% input data
I_i=zeros(1,I);
path=1;
path_all1=[]; 
scheduleTables = {};
pairingTables = {};
Rho1=Rho;
o1=find(234==DptrStn1);
flag=1;
step=1;%计数器
EmpNo = 1;
for o=o1'
disp(['第一个基地第',num2str(o),'的起点'])
%% 求环
[path,scheduleTable,pairingTable]=PathGenerate0(Rho1,o,EmpNo);
path=delete_od(path);
    if ~isempty(path)
        step=1;
        temp_path=zeros(1,I);
        temp_path(1:length(path))=path;
        path_all1=[path_all1;temp_path];
        scheduleTables = [scheduleTables;scheduleTable];
        pairingTables = [pairingTables;pairingTable];
        EmpNo = EmpNo + 1;
        I_i(path)=1;
        [I2,I_i]=notismember(path,I_i);
        Rho2=Rho1;
        Rho2(I2,path)=0;
        Rho2(path,I2)=0;
        Rho2(path,path)=0;
        Rho1=Rho2;
        disp(['第一个基地',num2str(flag),'个环完成'])
        flag=flag+1;
    elseif step<=10
        step=step+1;
    elseif step>10
        break
    end
end


path_all1=sort_zero(path_all1);
[a1,b1]=find(path_all1~=0);
num_flight=length(b1);
num_f = [];
for i = 1:max(a1)
    n1 = length(find(i==a1));
    num_f=[num_f,n1];
end
%% 保存航班
save path12 path_all1 num_flight scheduleTables pairingTables
output_flight(path_all1,I2); 
writetable(scheduleTables,'scheduleTables.csv')
writetable(pairingTables,'pairingTables.csv')
% Define the Excel filename
filename = 'result3A.xlsx';
writetable(pairingTables,filename,'Sheet','任务环表')
writetable(scheduleTables,filename,'Sheet','执勤表')
toc