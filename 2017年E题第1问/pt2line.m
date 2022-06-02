function line_value=pt2line(route,Time)
    line_value=[];
    for r=1:length(route)-1
        line_value=[line_value;[route(r),route(r+1)],Time(r+1)];
    end
end