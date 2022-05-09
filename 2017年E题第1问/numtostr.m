function path=numtostr(Result)
[a,b]=size(Result);
path=cell(a,1);
for k=1:a
    for n=1:b
        if Result(k,n)>0&&Result(k,n)<=30
            path{k}=[path{k},'D',num2str(Result(k,n)-10),' '];
        elseif Result(k,n)>=200&&Result(k,n)<=300
            path{k}=[path{k},'F',num2str(Result(k,n)-200),' '];
        elseif Result(k,n)>=300&&Result(k,n)<=400
            path{k}=[path{k},'J',num2str(Result(k,n)-300),' '];
        elseif Result(k,n)>=400
            path{k}=[path{k},'Z',num2str(Result(k,n)-400),' '];
        end
    end
end
end