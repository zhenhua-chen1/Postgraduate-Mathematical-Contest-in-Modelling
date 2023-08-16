function Dataget()
dataA_Crew=readtable('机组排班Data A-Crew.csv');
dataA_Flight=xlsread('机组排班Data A-Flight.xlsx');


%% 将导入的数组分配给列变量名称
% DptrTime1 = dataA_Flight(:,10);
% DptrStn1 = dataA_Flight(:,2);
% ArrvTime1 = dataA_Flight(:,14);
% ArrvStn1 = dataA_Flight(:,5);
% DptrDay = dataA_Flight(:,8);
% ArrvDay = dataA_Flight(:,12);
% VarName12 =dataA_Flight(:,6);
% VarName13 = dataA_Flight(:,7);
% VarName15 = dataA_Flight(:,9);
% VarName16 = dataA_Flight(:,10);
% FltNum2 = dataA_Flight(:,11);

DptrTime1 = dataA_Flight(:,10);
DptrStn1 = dataA_Flight(:,2);
ArrvTime1 = dataA_Flight(:,14);
ArrvStn1 = dataA_Flight(:,5);
DptrDay = dataA_Flight(:,8);
ArrvDay = dataA_Flight(:,12);
VarName12 =dataA_Flight(:,6);
VarName13 = dataA_Flight(:,7);
VarName15 = dataA_Flight(:,9);
VarName16 = dataA_Flight(:,10);
FltNum2 = dataA_Flight(:,11);

% 对于要求日期序列(datenum)而不是日期时间的代码，请取消注释以下行，以便以 datenum 形式返回导入的日期。

% DptrDate3=datenum(DptrDate3);
% ArrvDate3=datenum(ArrvDate3);
FLI=[FltNum2,VarName13,DptrStn1,VarName16,ArrvStn1];
base=234;%基地
Dptr_I1=find(DptrStn1==base(1));
Arrv_I1=find(ArrvStn1==base(1));
I=length(FltNum2);
Rho=zeros(I,I);
for i1=1:I
    for i2=1:I
        if i1<i2
            if ArrvStn1(i1)==DptrStn1(i2) && (DptrTime1(i2)-ArrvTime1(i1))>=40/(24*60)
                Rho(i1,i2)=1;
            end
        end
    end
end
people=height(dataA_Crew);
MaxBlk=600;%一次执勤飞行时长
MinRest=660;%休息时间
MaxDP=720;%执勤时长
MinVacDay = 2;%the min rest day
MaxSuccOn = 4;%the continuous duty
MaxTAFB = 14400;%最大任务环时间
save data
end