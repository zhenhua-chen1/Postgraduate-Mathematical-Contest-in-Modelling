function [p,o]=find_m(m,p1,o)
%该函数用于找到相同材料的批次
load data
temp_data = data;
temp_data(p1,:)=[];
temp_m = temp_data{:,2};%寻找材料
idx = find(ismember(temp_m,m));
idx1 = [];
for o1 =o'
    [pos1,~] = find(data{:,6}==o1);
    temp_data = data{pos1,2};
    a = ismember(temp_data,m);
    if sum(a) ~=0
        idx = length(find(ismember(temp_data,m)));
    else
        idx =0;
    end
    idx1 = [idx1;idx];
end
[max_value,pos] = max(idx1);
if length(pos)==1
    p = o(pos);
    o(pos) = []; 
else
    p = o(1);
    o(1) = 1;
end

end