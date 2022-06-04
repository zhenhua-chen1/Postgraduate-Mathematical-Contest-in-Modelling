function [c,R_c,c2]=Tree_building(o,Ca,t)%Tree-building algorithm for origin o(backnode means the minimum in the right-hand side of);
%% step0£ºstart
node=length(Ca);% Set the number of node;
c=10000000*ones(1,node);% Set c(o,n) is ¡Þ;
c(1,o)=0;% Set c(o,o) is 0;
nodeactive(1,node)=0;%Set the node n that is inactive;
nodeactive(1,o)=1;%Set the node o that is active;
po=zeros(1,node);% Set the po is the array of backnode;
%% step1
while 1
%% step2: minimum cost
    pos=find(nodeactive==1)';
    least_cost=[c(pos)',pos];
    [~,n]=min(least_cost(:,1));
    n=least_cost(n,2);  %select a node at least cost;
        for m=1:node
            if c(n)+Ca(n,m)<c(m)
                c(m)=c(n)+Ca(n,m); % minimum cost to reach;
                po(m)=n;   %(backnode of m);
 %% step3:Set the node m that is active;
                nodeactive(m)=1;
            end
        end
        nodeactive(n)=0 ;% Set the node 1 that is inactive;
        c;
        po;
%% step4:if there is an active node,then return to step1;
    if nodeactive==0
        break
    end
end 
R_c=[t];
s=t;
c2=c;
c=c(t);
while 1
 if s~=o
     R_c=[po(s),R_c];
     s=po(s);
 else
     break
 end
end
end
