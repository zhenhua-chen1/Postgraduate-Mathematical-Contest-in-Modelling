function [path,time1,time2,time3,time4,startnum]=PathGenerate0(Rho2,o,~)
load data
flightdata=dataA_Flight;
Rho=Rho2;
time1=zeros(1,I);%执勤开始时刻
time2=zeros(1,I);%执勤开始日
time3=zeros(1,I);%执勤飞行时间
time4=zeros(1,I);%执勤结束时间
time2(1)=flightdata(o,8);
time1(1)=flightdata(o,9);
startnum=zeros(1,I);%每次执勤开始航班
k=1;%执勤次数
i=o;
step=1;
path(1)=o;
min_j=find(Rho(o,:)==1);
while i~=I&&step<=I
%     min_j=find(Rho(i,:)==1);
    for j=min_j
        if i<j&&Rho(i,j)==1
            if (flightdata(j,13)-time1(k))*24*60<=MaxDP&&flightdata(j,8)==time2(k)&&(time3(k)+(flightdata(j,13)-flightdata(j,9)))*24*60<=MaxBlk  
                path=[path,j];
                time3(k)=time3(k)+(flightdata(j,13)-flightdata(j,9));
                i=j;
                min_j=find(Rho(i,:)==1);
            elseif flightdata(j,8)>time2(k)&&(flightdata(j,10)-flightdata(i,14))*24*60>MinRest 
                path=[path,j];
                time4(k)=(flightdata(j,9)-flightdata(i,13));
                i=j;
                min_j=find(Rho(i,:)==1);
                k=k+1;
                time1(k)=flightdata(j,13);
                time2(k)=flightdata(j,8);
                time3(k)=0;
                startnum(k)=j;
                break
            else
                continue
            end
        end
    end
  step=step+1;  
end
[~,b]=size(path);
time4(k)=flightdata(path(b),4);
end 