function [c,po,e_h,e_a,e_h_1,e_a_1,prob_e]=Dijkstra_2(o,Ca)
load data
node=length(Ca);% 总结点数;
e_h=zeros(1,node);% 垂直误差;
e_a=zeros(1,node);% 水平误差;
e_h_1=zeros(1,node-1);% 校正前垂直误差;
e_a_1=zeros(1,node-1);% 校正前水平误差;
prob_e=ones(1,node-1);% 该点是否修正成功;
c=1000000000000000000*ones(1,node);% 选择 c(o,n) 时 ∞;
c(1,o)=0;% 选择 c(o,o) 时 0;
nodeactive(1,node)=0;%选择节点n是非标记点;
nodeactive(1,o)=1;%选择节点n是标记点;
po=zeros(1,node);% 选择节点n是backnode;
while 1
    pos=find(nodeactive==1)';
    least_cost=[c(pos)',pos];
    [~,n]=min(least_cost(:,1));
    n=least_cost(n,2);  %选择一个最小值点;
        for m=1:node
            if m~=node && m~=1
                if ess(m-1)==1 %判断是哪个纠正点
                    if prob(m-1)==1&& rand>mp %判断垂直校正是否成功
                            if (c(n)+Ca(n,m)<c(m))&&((e_h(n)+Delta*Ca(n,m)<=alhpa_1)&&(e_a(n)+Delta*Ca(n,m)<=alhpa_2))
                                c(m)=c(n)+Ca(n,m); %更新成本;
                                e_h(m)=e_h(n)+Delta*Ca(n,m);
                                e_h(m)=min(5,e_h(m));
                                prob_e(m)=0;%校正失败
                                e_a(m)=e_a(n)+Delta*Ca(n,m);% 增加水平误差;
                                e_a_1(m-1)=e_a(m);%校正后的水平误差
                                po(m)=n;   %(backnode of m);
                                nodeactive(m)=1;
                            end         
                    else
                        if (c(n)+Ca(n,m)<c(m))&&((e_h(n)+Delta*Ca(n,m)<=alhpa_1)&&(e_a(n)+Delta*Ca(n,m)<=alhpa_2))
                            c(m)=c(n)+Ca(n,m); %更新成本;
                            e_h(m)=0;
                            e_a(m)=e_a(n)+Delta*Ca(n,m);% 增加水平误差;
                            e_a_1(m-1)=e_a(m);%校正后的水平误差
                            po(m)=n;   %(backnode of m);
                            nodeactive(m)=1;
                        end
                    end
                else
                    if prob(m-1)==1&& rand>mp %判断水平校正是否成功
                            if (c(n)+Ca(n,m)<c(m))&&((e_h(n)+Delta*Ca(n,m)<=Beta_1)&&(e_a(n)+Delta*Ca(n,m)<=Beta_2))
                                c(m)=c(n)+Ca(n,m); %更新成本;
                                e_a(m)=e_a(n)+Delta*Ca(n,m);
                                e_a(m)=min(5,e_a(m));
                                prob_e(m)=0;%校正失败
                                e_h(m)=e_h(n)+Delta*Ca(n,m);% 增加水平误差;
                                e_h_1(m-1)=e_h(m);%校正后的水平误差
                                po(m)=n;   %(backnode of m);
                                nodeactive(m)=1;
                            end 
                    else
                        if (c(n)+Ca(n,m)<c(m))&&((e_h(n)+Delta*Ca(n,m)<=Beta_1)&&(e_a(n)+Delta*Ca(n,m)<=Beta_2))
                            c(m)=c(n)+Ca(n,m); %更新成本;
                            e_a(m)=0;
                            e_h(m)=e_h(n)+Delta*Ca(n,m);% 增加垂直误差;
                             e_h_1(m-1)=e_h(m);%校正前的垂直误差
                            po(m)=n;   %(backnode of m);
                            nodeactive(m)=1;
                        end  
                    end
                end
            elseif  m==node
                if(c(n)+Ca(n,m)<c(m))&&(e_h(n)+Delta*Ca(n,m)<theta)&&((e_a(n)+Delta*Ca(n,m)<theta))
                    c(m)=c(n)+Ca(n,m); %更新成本;
                    e_a(m)=e_a(n)+Delta*Ca(n,m);
                    e_h(m)=e_h(n)+Delta*Ca(n,m);
                    e_a_1(m-1)=e_a(m);
                    e_h_1(m-1)=e_h(m);
                    po(m)=n;   %(backnode of m);
                end
            end  
        end
        nodeactive(n)=0 ;% 选择节点n是非标记点;
    if nodeactive==0;
        break
    end
 end    
end
