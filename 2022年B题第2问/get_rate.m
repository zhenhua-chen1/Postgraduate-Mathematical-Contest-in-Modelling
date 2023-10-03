function ad_rate = get_rate(item2,positon2)
load data1
s = 0;
    for i=1:length(item2)
        pos = item2(i);
        a = data1{pos,4};
        b = data1{pos,5};
        s = s+a*b;
    end
    S=Height*Length;
    ad_rate = s/S;
%     figure
%     if max(positon2(:,1))<1220
%         plot(positon2(:,1), positon2(:,2), 'o')
%         xlim([0,1220])
%         ylim([0,2440])
%     else
%         plot(positon2(:,1), positon2(:,2), 'o')
%         xlim([0,1220])
%         ylim([0,2440])
%     end

end