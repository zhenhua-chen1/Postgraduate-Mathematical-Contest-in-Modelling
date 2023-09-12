function [value,pos2] = sort_value(square,x)
        [pos1,pos2]=find(square==x);
        pos2(pos2==2)=3;
        pos2(pos2==1)=2;
        pos2(pos2==3)=1;
        value = [];
        for p = 1:length(pos1)
            value =[value;square(pos1(p),pos2(p))];
        end
       [value,pos] =sort(value);
       pos2 = pos2(pos);
end