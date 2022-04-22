function w=get_walk(Direction_j1,type_j1,Direction_j2,type_j2)
load data
if type_j1==type_j2 %判断类型是否相等
    if Direction_j1==Direction_j2 %判断方向是否相等
        w=10;
    elseif Direction_j1==Center||Direction_j2==Center
        w=15;
    else
        w=20;
    end
else
    if Direction_j1==Center&&Direction_j2==Center
        w=15;
    elseif (Direction_j1==Center)||(Direction_j2==Center)
        w=20;
    else
        w=25;
    end
    
end
end