function position2 = find_postion(stack2,position,v)
load data
[~,p] = find(stack2==v);
if p==1
   p=2;
   Dis = Height;
   dis = stack2(p);
else
    p=1;
    Dis = Length;
    dis = stack2(p);
end
delta = Dis - dis;%求差值
[pos1,pos2] = find(position == delta);
% if isempty(pos1)
%    [a,p]= min(abs(delta - position(:,p)));
%    position2 = position(p,:);
% else 
%     position2 = position(pos1,:);
%     
% end
position2 = position(pos1,:);

end