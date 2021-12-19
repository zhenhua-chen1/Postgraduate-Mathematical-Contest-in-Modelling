function draw(path,pos)
load data
path_len=length(path);
pos_2=[];
for i=1:path_len
    pos_2=[pos_2;path(i),pos(path(i),1),pos(path(i),2),pos(path(i),3)];
end
x=pos_2(:,2);y=pos_2(:,3);z=pos_2(:,4);
%% »­Í¼
plot3(pos(1,1),pos(1,2),pos(1,3),'ko','MarkerFaceColor','k','MarkerSize',4);
hold on
plot3(pos(NodeAmount,1),pos(NodeAmount,2),pos(NodeAmount,3),'ko','MarkerFaceColor','k','MarkerSize',4);

for i=1:NodeAmount-2
    if ess(i)==1
        plot3(pos(i+1,1),pos(i+1,2),pos(i+1,3),'bo','MarkerFaceColor','b','MarkerSize',4);
        hold on
    else
         plot3(pos(i+1,1),pos(i+1,2),pos(i+1,3),'yo','MarkerFaceColor','y','MarkerSize',4);
         hold on
    end
end

hold on
% for i = 1:path_len
%     Str = int2str(path_len(i));
%     text(pos_2(i,2)+1/100,pos_2(i,3)+1/100,pos_2(i,4)+1/100,Str,'FontName','Times New Roman','FontSize',12);
%     hold on;
% end
for i = 1:path_len-1
     plot3([x(i),x(i+1)],[y(i),y(i+1)],[z(i),z(i+1)],'k');
     hold on;
     grid on;
end
	plot3([x(path_len-1),x(path_len)],[y(path_len-1),y(path_len)],[z(path_len-1),z(path_len)],'k');
end
% plot3([x(1),x(2)],[y(1),y(2)],[z(1),z(2)],'r');
% hold on;
% % plot3([pos(1,1),pos(2,1)],[pos(1,2),pos(2,2)],[pos(1,3),pos(2,3)],'k');
% % hold on;