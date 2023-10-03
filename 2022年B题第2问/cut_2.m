function  [stripe,stack,square,temp_data,item,value,positon]= cut_2(Length,Height,square,temp_data,flag,max_p)
%选择横切还是竖切
len = 2440;
hig = 1220;
% temp_data2=[square(:,1);square(:,2)];
% x = tabulate(temp_data2);
% x = sortrows(x,-2); %按照第二列排序，其他列与排序结果一一对应。stripe = Length;
% value = x(1);
stack=[];
stripe = [];
if flag == 1
    temp_stripe = Height; %选择横切
    temp_stripe2 =  temp_stripe;
    temp_stack = Length;
    temp_stack2 = temp_stack;
    [pos1,pos2] = find(square<Height);
    if isempty(pos2)
        return
    end
    value2 = find_value(square,pos1,pos2);%找到对应的长度并排序
    if isempty(value2)
        return
    end
    ind = find(value2(1,:)<Height);
    if length(ind)~=1
        [~,ind] = min([Height-value2(1,1),Height-value2(1,2)]);
    end
    value = value2(1,ind);
    max_stripe = floor(temp_stripe/value);
%    value =
    %stripe = [Length,temp_stripe-max_stripe*value];
else
    temp_stripe = Length; %选择竖切
    temp_stripe2 = temp_stripe;
    temp_stack = Height;
    temp_stack2 =  temp_stack;
    %stripe = [temp_stripe-max_stripe*value,Height]
    [pos1,pos2] = find(square<Length);
    if isempty(pos2)
        return
    end
    value2 = find_value(square,pos1,pos2);%找到对应的长度并排序
    if isempty(value2)
        return
    end
    ind = find(value2(1,:)<Length);
    if length(ind)~=1
        [~,ind] = min([Length-value2(1,1),Length-value2(1,2)]);
    end
    value = value2(1,ind);
    max_stripe = floor(temp_stripe/value);
end
 
 [value2,p] =  sort_value(square,value);%提取value
item=[];
positon = [];
n=1;
temp_y=0;
for j=1:length(value2)
    v=value2(j);
    pos=p(j);
    if n<= max_stripe
        if temp_stack-v>0 && temp_y+v<=temp_stack2 
            temp_y=temp_y+v;
            temp_stack = temp_stack-v;
            temp_row = find_pos2(v,pos,value,temp_data);%找到对应的项目
            item=[item;temp_row ];
            %[~,ia2]=intersect(square, v,'row');
            if pos ==1
                temp_s2 = [v,value];
            else
                temp_s2 = [value,v];
            end
            temp_data(temp_row,:)=0;
            positon = [positon;[max_p+n*value-temp_s2(1,2),temp_y+v-temp_s2(1,1)]];
            [~,ia2]=intersect(square,temp_s2,'row');
            square(ia2,:)=[];
        else
            if pos == 1 
                stack=[stack;[temp_stack,value]];
            else
                stack=[stack;[value,temp_stack]];
            end
            temp_stack=temp_stack2;
            n=n+1;
        end
    end
end
if n==1
    if pos == 1 
        stack=[stack;[temp_stack,value]];
    else
        stack=[stack;[value,temp_stack]];
    end
    temp_stack=temp_stack2;
    n=n+1;
end
    if flag == 1
        stripe = [Length,temp_stripe-(n-1)*value];
    else
        stripe = [temp_stripe-(n-1)*value,Height];
    end   
end