function path=delete_od(path)
load data
while ~isempty(path)
    if (DptrStn1(path(1)))~=base(1) && (DptrStn1(path(1)))~=base(2)
        path(1)=[];
    elseif (DptrStn1(path(1)))==base(1) && (ArrvStn1(path(end)))~=base(1) 
        path(end)=[];
    elseif (DptrStn1(path(1)))==base(1) && (ArrvStn1(path(end)))==base(1) 
        break
    elseif (DptrStn1(path(1)))==base(2) && (ArrvStn1(path(end)))~=base(2) 
        path(end)=[];
    elseif (DptrStn1(path(1)))==base(2) && (ArrvStn1(path(end)))==base(2) 
        break       
    end
end
end