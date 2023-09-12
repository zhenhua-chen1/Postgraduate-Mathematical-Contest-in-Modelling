function value = find_value(square,pos1,pos2)%找到对应的长度
    value = [];
    for p = 1:length(pos1)
            value =[value;[square(pos1(p),:)]];           
    end
    %重新排序
    temp_value = [];
    temp_value2 = [];
    [a,~] = size(value);
    for i=1:a-1
       if value(i+1,2)~=value(i,2)
           temp_value2 = [temp_value2;value(i,:)];
           temp_value = [temp_value2;temp_value];
           temp_value2 = [];
       else
           temp_value2 = [temp_value2;value(i,:)];
       end
          
    end
    value = [temp_value;value(end,:)];
end