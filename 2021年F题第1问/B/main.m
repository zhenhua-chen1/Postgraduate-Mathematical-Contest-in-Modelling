clc
clear 
close all
disp('读取数据')
dbstop if error
%Dataget()
% a=breakdown(path1);
load data
tic
%% 输入数据
I_i=zeros(1,I);
path=1;
path_all1=[];
path_all2=[];
Rho1=Rho;
o1=find(base==DptrStn1);
o2=find(base==DptrStn1);
flag=1;
step=1;%计数器
for o=o1'
disp(['第一个基地第',num2str(o),'的起点'])
%% 求环
path=PathGenerate0(Rho1,o);
path=delete_od(path);
    if ~isempty(path)
        step=1;
        temp_path=zeros(1,I);
        temp_path(1:length(path))=path;
        path_all1=[path_all1;temp_path];
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
flag=1;
step=1;
for o=o2'
disp(['第二个基地第',num2str(o),'的起点'])
%% 求环
path=PathGenerate0(Rho1,o);
path=delete_od(path);
    if ~isempty(path)
        step=1;
        temp_path=zeros(1,I);
        temp_path(1:length(path))=path;
        path_all2=[path_all2;temp_path];
        I_i(path)=1;
        [I2,I_i]=notismember(path,I_i);
        Rho2=Rho1;
        Rho2(I2,path)=0;
        Rho2(path,I2)=0;
        Rho2(path,path)=0;
        Rho1=Rho2;
        disp(['第二个基地',num2str(flag),'个环完成'])
        flag=flag+1;
    elseif step<=15
        step=step+1;
    elseif step>15
        break
    end
end

path_all1=sort_zero(path_all1);
path_all2=sort_zero(path_all2);
[a1,b1]=find(path_all1~=0);
[a2,b2]=find(path_all2~=0);
a3=intersect(path_all1,path_all2);
num_flight=length(b1)+ length(b2);
%% 保存航班
save path11 path_all1 path_all2 num_flight
output_flight(path_all1,path_all2,I2); 
toc