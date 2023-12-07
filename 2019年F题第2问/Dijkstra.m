function [min_cost,path_len,path,e_h,e_a]=Dijkstra(o,Ca,B)
load data
node=length(Ca);% 总结点数;
e_h=zeros(1,node);% 垂直误差;
e_a=zeros(1,node);% 水平误差;
e_h_1=zeros(1,node-1);% 校正前垂直误差;
e_a_1=zeros(1,node-1);% 校正前水平误差;
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
    disp(['Finding the most suitable point in ', num2str(n)])
        for m=1:node
            %计算转弯半径
            if po(n)~=0 && m~=n && n~=po(n) && m~=po(n)
                R = calculate_turning_radius(po(n), n, m);
            else
                R = inf;
            end
            %判断转弯半径是否符合约束
                if m~=node && m~=1
                    if ess(m-1)==1 %判断是哪个纠正点
                        if (c(n)+Ca(n,m)<c(m))&&((e_h(n)+Delta*Ca(n,m)<=alhpa_1)&&(e_a(n)+Delta*Ca(n,m)<=alhpa_2))&&R>200
                            c(m)=c(n)+Ca(n,m); %更新成本;
                            e_h(m)=0;
                            e_a(m)=e_a(n)+Delta*Ca(n,m);% 增加水平误差;
                            e_a_1(m-1)=e_a(m);%校正后的水平误差
                            po(m)=n;   %(backnode of m);
                            nodeactive(m)=1;
                        end
                    else
                        if (c(n)+Ca(n,m)<c(m))&&((e_h(n)+Delta*Ca(n,m)<=Beta_1)&&(e_a(n)+Delta*Ca(n,m)<=Beta_2))&&R>200
                            c(m)=c(n)+Ca(n,m); %更新成本;
                            e_a(m)=0;
                            e_h(m)=e_h(n)+Delta*Ca(n,m);% 增加垂直误差;
                            e_h_1(m-1)=e_h(m);%校正前的垂直误差
                            po(m)=n;   %(backnode of m);
                            nodeactive(m)=1;
                        end  
                    end
                elseif  m==node
                    if(c(n)+Ca(n,m)<c(m))&&(e_h(n)+Delta*Ca(n,m)<theta)&&((e_a(n)+Delta*Ca(n,m)<theta))&&R>200
                        c(m)=c(n)+Ca(n,m); %更新成本;
                        e_a(m)=e_a(n)+Delta*Ca(n,m);
                        e_h(m)=e_h(n)+Delta*Ca(n,m);
                        e_a_1(m-1)=e_a(m);
                        e_h_1(m-1)=e_h(m);
                        po(m)=n;   %(backnode of m);
                        nodeactive(m)=1;
                    end
                end  
            %nodeactive(m)=1;
        end
        nodeactive(n)=0 ;% 选择节点n是非标记点;
    if nodeactive==0
        break
    end
end    
 [min_cost,path_len,path]=Search_path(B,NodeAmount,c,A,po);
end
function [min_cost,path_len,path]=Search_path(d,node,c,o,po)
    path=d;
    A=node;
    min_cost=c(A);
    while A~=o
          A=po(A);
          path=[A,path];
    end
    
    path_len=length(path);
end
