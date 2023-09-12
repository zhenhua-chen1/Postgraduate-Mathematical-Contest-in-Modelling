function path=sort_zero(path)
% load result1
% path = unique(path,'rows')
load data
a=[];
[ran,col]=size(path);
for i=1:ran
   a2=path(i,:);
   a2(find(path(i,:)==0))=[];
   a1=length(a2);
   a=[a;a1];
end
[a,j]=sort(a,1,'descend');
path=path(j,:);
end