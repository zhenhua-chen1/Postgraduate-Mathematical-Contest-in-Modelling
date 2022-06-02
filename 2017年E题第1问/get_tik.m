function Time=get_tik(Route,Time)
load data
Link={};
for i=1:vehicle
    route=Route(i,:);
    time=Time(i,:);
    [route2,~]=find(route==data(:,1));
    route=route2';
    line_value=pt2line(route,time);
    Link=[Link;line_value];
end
double_line_if=ones(length(double_line),1);%whether it is used
% devise the time
for i=1:vehicle
  Link2=Link{i};
  for j=1:vehicle
      if i~=j
      temp_Link2=Link{j};
          for Lin=Link2'
              a=find((Lin(1)==temp_Link2(:,1))&(Lin(2)==temp_Link2(:,2))&(Lin(3)==temp_Link2(:,3)), 1);
              if ~isempty(a)
                  b=find(Lin(1)==double_line(:,1)&Lin(2)==double_line(:,1), 1);%judge whether is the double line
                  if ~isempty(b)
                    if double_line_if(b)
                        double_line_if(b)=0;
                        break
                    end
                  end
                  Link{j}(a:end,3)=temp_Link2(a:end,3)+Lin(3);
              end
          end
      end
  end
end
%renew time
for i=1:vehicle
    for j=1:length(Link{i})
        Time(i,j+1)=Link{i}(j,3);
    end
end
end