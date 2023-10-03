function [temp_square,x] = extraction(data1)
 data = [data1{:,4};data1{:,5}];
 square = [data1{:,4},data1{:,5},data1{:,6}];
%square = [data1{:,4},data1{:,5}];
 x = tabulate(data);
 x = sortrows(x,-2); %按照第二列排序，其他列与排序结果一一对应。
 temp_square=[];
 for i=1:length(x)
     [pos1,pos2] = find(square(:,1:2)==x(i));
     temp_square2 = [];
     for p=1:length(pos1)
         if sum(square(pos1(p),:))~=0
             if pos2(p)==1
                temp_square2 = [temp_square2;square(pos1(p),3),x(i),square(pos1(p),2)];
                square(pos1(p),:)=[0,0,0];
             else
                 temp_square2 = [temp_square2;square(pos1(p),3),square(pos1(p),1),x(i)];
                 square(pos1(p),:)=[0,0,0];
             end
        end
     end
     temp_square3=[];
     if ~isempty(temp_square2)
        [value,pos2] = sort_value(temp_square2(:,2:3),x(i,1));
         for p=1:length(pos2)
             if pos2(p)==1
                 temp_square3 = [temp_square3;[value(p),x(i,1)]];
             else
                 temp_square3 = [temp_square3;[x(i,1),value(p)]];
             end
         end
         temp_square = [temp_square;temp_square3];  
     end
 end
end
