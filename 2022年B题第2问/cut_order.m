function [twt,s] = cut_order(Batch)
    %load Batch
    load data
    iter = 1;
    twt = {'批次序号','原片材质','原片序号','产品id','产品x坐标','产品y坐标','产品x方向长度','产品y方向长度'};
    n_M = 1;
    s = 0;
    n_M2= 0;
    advance2 = [];
    for b =1:length(Batch)
        disp(['开始第',num2str(iter),'批次切割订单'])
        Batch2 = Batch{b};
        item12 = data(Batch2,:);
        item12 = sortrows(item12,'item_material','descend');
        x = tabulate(item12{:,2});
        x2 = x(:,1);
        for item_p=1:length(x2)
            item_material = x2{item_p};
            pos = find(ismember(item12{:,2},item_material));
            data1 = item12(pos,:);
            [square,x] = extraction(data1);
            Length = 2440;
            Height = 1220;
            save data1 data1 Height Length folder_path
            temp_data = data1{:,[4,5]};
            %开始切割
            Materials = {};
            i=1;
            while sum(sum(temp_data))~=0
                positon2=[];
                item2=[];
                %disp(['拿出第',num2str(i),'块板'])
                temp_length = Length;
                temp_height = Height;
                %iter = 0;
                flag = 1;
                %while flag==1
                while iscut(temp_length,temp_height,square) 
                    %切割条带和栈或栈和项目
                    if flag == 1
                        [stripe,stack,square,temp_data,item,f,v,positon]= cut_1(temp_length,temp_height,square,temp_data);
                        flag = 0;
                        max_p = max(positon(:,1));
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
            %开始记录
            [M_s,~] = size (Materials);
            for M = 1:M_s
                n_M3 = n_M2+M;
                ind = Materials{M,1};
                pos = Materials{M,3};
                flag = Materials{M,4};%横放还是竖放
                for i = 1:length(ind)
                    i2 = ind(i);
                    item_i2x = data1{i2,4};
                    item_i2y = data1{i2,5};
                    pos_x = pos(i,1);
                    pos_y = pos(i,2);
                    if flag ==1
                        twt=[twt;iter,data1{i2,2},n_M3,data1{i2,1},pos(i,1),pos(i,2),item_i2y,item_i2x];
                    else
                        twt=[twt;iter,data1{i2,2},n_M3,data1{i2,1},pos(i,1),pos(i,2),item_i2x,item_i2y];
                    end
                end
            end
            n_M2 = n_M3;
            polt_result(Materials,b);
            advance = Materials(:,2);
            advance2 = [advance2;cell2mat(advance)];
            for a = 1:length(advance)
                s=s+advance{a};
            end
            %[twt,rate] = write2table(Materials,iter);
        end
    iter = iter +1;
    end
   
    s = s/length(advance2);
    writecell(twt,'sum_order5.xlsx')
end