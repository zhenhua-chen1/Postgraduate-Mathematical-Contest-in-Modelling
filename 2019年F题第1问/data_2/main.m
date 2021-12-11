clc
clear 
close all
%% 读取数据
DataGet()
load data

%% 调用算法
[min_cost,path_len,path,e_h,e_a]=Dijkstra_1(A,dij,B);
[path]=draw_airline(path_len,path);

%% 提取结果
disp(['水平误差为：',(num2str((e_a(path+1))))])
disp(['垂直误差为：',(num2str((e_h(path+1))))])
path

