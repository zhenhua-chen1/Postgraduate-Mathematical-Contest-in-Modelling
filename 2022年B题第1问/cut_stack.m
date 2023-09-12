function [square,temp_data,item,positon]= cut_stack(stack,square,temp_data,item,v,positon,f)
    %load data
    if f ==1
        height_stack = stack(1,2);%条带长度
        pp = 1;
        ps = 2;
    else
        height_stack = stack(1,1);%条带长度
        pp = 2;
        ps = 1;
    end
    [pos1,pos2] = find((square(:,ps)<height_stack));
%     pos1 = intersect(pos1,pos13);
%     pos2 = intersect(pos2,pos23);
    if isempty(pos2)
        return
    end
    value = find_value(square,pos1,pos2);%找到对应的长度并排序
    if isempty(value)
        return
    end
    %[value,pos2] = sort_value(square,pos2);
    %去除没有用的板和不能算的item
    min_v = min(value(:,pp));
    pos3 = find(stack(:,pp)>min_v);
    if isempty(pos3) 
        return
    end
    stack2 = stack(pos3,:);
    max_v = max(stack2(:,pp));
    pos4 = find(value(:,pp)<=max_v);
   if isempty(pos4) 
        return
    end
    value = value(pos4,:);
    stack2 = sortrows(stack2,-1);
    %开始切割栈
    [S,~] = size(stack2);
    for s = 1:S
        length = stack2(s,pp);
%         value1 = value(1,pp);
%         value2 = value(1,ps);
        if isempty(positon)
            return
        end
        position2 = find_postion(stack2(s,:),positon,v);
        if isempty(position2)||isempty(positon)
            return
        end
        while length-value(1,pp)>0 && position2(1)-v+value(1,ps)>=0 && position2(2)+value(1,pp)>=0
            length = length-value(1,pp);
            [~,ia1]=intersect(temp_data, value(1,:),'row');
            [~,ia2]=intersect(square, value(1,:),'row');
            dis=temp_data(ia1,:);
            p=[position2(1)-v+value(1,ps),position2(2)+value(1,pp)];
            temp_data(ia1,:)=0;
            square(ia2,:)=[];
            item=[item;ia1];
            positon = [positon;p];
            value(1,:)=[];
            if isempty(value) %如果切完退出
                return
            end
        end
        
    end
end