function [min_cost,path_len,path]=Search_path(d,node,c,o,po)
    path=d;
    A=node;
    min_cost=c(A);
    while A~=o
          A=po(A);
          path=[A,path];
    end
    
    path_len=length(path);
end