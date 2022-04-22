function pos=find_pos(i1,datai1,data1,date_a)
log=[i1,datai1]==[data1,date_a];
pos=find(log(:,1).*log(:,2));
end