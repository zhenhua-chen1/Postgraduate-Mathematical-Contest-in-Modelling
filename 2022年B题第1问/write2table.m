function  rate = write2table(Materials)
load data
twt={'原片材质','原片序号','产品id','产品x坐标','产品y坐标','产品x方向长度','产品y方向长度'};
for M = 1:length(Materials)
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
            twt=[twt; data1{i2,2},M,data1{i2,1},pos(i,1),pos(i,2),item_i2y,item_i2x];
        else
            twt=[twt; data1{i2,2},M,data1{i2,1},pos(i,1),pos(i,2),item_i2x,item_i2y];
        end
    end
    
end
ind = Materials(:,1);
advance = Materials(:,2);
s=0;
for a = 1:length(advance)
    s=s+advance{a};
end
writecell(twt,[fileName,'cut.xlsx'])
rate = s/a;
end