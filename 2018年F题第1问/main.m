clc
clear all
DataGet()
load data
Cij=zeros(Z,N);%i是否被分配到j
% [~,row]=sort(td_i-ta_i);
% [~,row]=sort(ta_i);
% Z=row';
% for i=1:Z-1
%     t_c(i)=ta_i(i+1)-td_i(i);
% end
Z=1:Z;
for i1=Z
    % 使用过的登机口放前面
    [~,b]=find(Cij==1);
    b=unique(b);
    N_1=1:N;
    N_1(b)=[];
    N_1=[b',N_1];
    for j=N_1
%          if sum(Cij(i1,:))==0 %i1是否被选择过
                 flag=ones(length(Z),1);
                  if Aij(i1,j)==1
                % 在j点i1与其他是否冲突
                        for i2=Z     
                             if i1~=i2
                                  if Cij(i2,j)==1%看是否被选择过
                                      if Bii(i1,i2)==0%i1与i2小于45分钟
                                         flag(i2)=0;
                                         break
                                       end
                                  end
                              end
                        end
                        if prod(flag)==1
                             Cij(i1,j)=1;
                             break
                        end
                  end
%          end
    end
end
[a,b]=find(Cij==1);
result=[a,b];
b2=unique(b);
for i=1:length(a)
    disp(['第',num2str(a(i)),'航班分配给',num2str(b(i)),'登机口']);
end
disp(['一共',num2str(length(a)),'个航班被分配'])
disp(['一共',num2str(length(b2)),'个登机口被使用'])

