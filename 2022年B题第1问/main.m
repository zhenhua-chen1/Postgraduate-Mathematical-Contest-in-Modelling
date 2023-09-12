clc
clear all
dataget()
dbstop if error
load data
temp_data = data1{:,[4,5]};
%开始切割
Materials = {};
i=1;
tic
while sum(sum(temp_data))~=0
    positon2=[];
    item2=[];
    disp(['拿出第',num2str(i),'块板'])
    temp_length = Length;
    temp_height = Height;
    iter = 0;
    flag = 1;
    %while flag==1
    while iscut(temp_length,temp_height,square) 
        %切割条带和栈或栈和项目
        if flag == 1
            [stripe,stack,square,temp_data,item,f,v,positon]= cut_1(temp_length,temp_height,square,temp_data);
            flag = 0;
            max_p = max(positon(:,f+1));
        else
        %切割条带剩余栈为项目(需与第一次方向一致)
            [stripe,stack,square,temp_data,item,v,positon]= cut_2(temp_length,temp_height,square,temp_data,f,max_p);
        end
        %切割剩余栈为项目
        [square,temp_data,item,positon]= cut_stack(stack,square,temp_data,item,v,positon,f);
        item2=[item2;item];
        positon2=[positon2;positon];
        if isempty(stripe)||isempty(square)
            break
        end
        temp_length = stripe(1);%改成剩余的条带
        temp_height = stripe(2);
    end
    i=i+1;
    ad_rate = get_rate(item2,positon2); 
    Materials = [Materials;{item2,ad_rate,positon2,f}];
    %write2table(Materials)
end
s_all = write2table(Materials);%输出结果
s = cell2mat(Materials(:,2));
polt_result(Materials,fileName);
[v,p] = sort(s,'descend' );
toc