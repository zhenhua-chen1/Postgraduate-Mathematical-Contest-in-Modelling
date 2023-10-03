clc
clear all
dbstop if error
dataget()
load data

%% 求出每个订单号的相同批次数量
num_order = length(order);
same_n = [];
mater = {};
for n = 1:num_order
    [pos1,~] = find(data{:,6}==n);
    mater_n = data{pos1,2};
    x = tabulate(mater_n);
    y = cell2mat(x(:,2));
    [same,p2] = max(y);
    mater =[ mater ;x{p2,1}];
    same_n = [same_n;same];
end
[same_n,order] = sort(same_n,'descend');%给材料众数排序
mater = mater(order);
%% 开始贪心算法批次
temp_pos = [];
n_item = 0;
s = 0 ;
Batch = {};
iter = 0;
order2 = order;
o1=order(1);
m = mater{1};
order(1)=[];
mater{1}=[];
tic
%n_p=0;
while 1
    [pos1,~] = find(data{:,6}==o1);
    temp_s = data{pos1,4}'*data{pos1,5};%求出所有item的总面积
    if n_item+length(pos1)<=1000 && s+temp_s<= max_item_area %判断item 是否小于1000或者面积小于Max
        n_item = n_item+length(pos1);
        s= s+temp_s;
        temp_pos = [temp_pos;pos1];%记录item
        [o1,order] = find_m(m,pos1,order);
        if isempty(order)
            [pos1,~] = find(data{:,6}==o1);
            temp_pos = [temp_pos;pos1];%记录item
            Batch = [Batch;temp_pos];
            %n_p = n_p+length(temp_pos); 
            iter = iter+1;
            disp(['第',num2str(iter),'批次分配完'])
            break
        end
    else
        Batch = [Batch;temp_pos];
        %n_p = n_p+length(temp_pos);
        iter = iter+1;
        n_item = 0 ;
        s = 0 ;
        temp_pos = [];
        disp(['第',num2str(iter),'批次分配完'])
    end
end
[twt,s] = cut_order(Batch);%开始切割
disp(['利用率为:',num2str(s)])
Batch_order = result_order(Batch);%输出订单
toc
