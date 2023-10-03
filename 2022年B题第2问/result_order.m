function Batch_order=result_order(Batch)
load data
Batch_order = {};
for b=1:length(Batch)
    Batch1 = Batch{b};
    item_order = data{Batch1,6};
    item_Materials = data{Batch1,2};
    x = tabulate(item_order);
    x = x(find(x(:,2)~=0),1:2);
    y = tabulate(item_Materials);
    y =y(:,1:2);
    Batch_order =[Batch_order;{b,x,y}];
    
end