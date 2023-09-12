function ia = find_pos2(v,p,x2,data)
load data
%data = data1{:,[1,4,5]};
if p ==1
 pos1 = [v,x2];
else
  pos1 = [x2,v]; 
end
[~,ia]=intersect(data,pos1,'row');
end