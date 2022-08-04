function fighlt_alt=find_replace(time)
    [i,j]=find(time~=0);
    num=tabulate(i);
    i_num=find(num(:,2)>=2);
    [~,num]=find(time(i_num,:)~=0);
    fighlt_alt=[];
    for n=1:length(num)-1
        if num(n+1)-num(n)==1
            fighlt_alt=[fighlt_alt,num(n+1)];
        end
    end

end