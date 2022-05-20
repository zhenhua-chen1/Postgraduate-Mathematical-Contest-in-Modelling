clc
clear all
%DataGet()
load data
Cij=zeros(Z,N);% is i assigned to j
Z=1:Z;
for i1=Z
    % used gates in front
    [~,b]=find(Cij==1);
    b=unique(b);
    N_1=1:N;
    N_1(b)=[];
    N_1=[b',N_1];
    for j=N_1
%          if sum(Cij(i1,:))==0 % Was i1 selected
                 flag=ones(length(Z),1);
                  if Aij(i1,j)==1
                % Is i1 in conflict with other at  j
                        for i2=Z     
                             if i1~=i2
                                  if Cij(i2,j)==1% See if it has been selected
                                      if Bii(i1,i2)==0% i1 & i2 less than 45 minutes
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
    disp(['the No.',num2str(a(i)),' flight is assigned the No.',num2str(b(i)),' gate']);
end
disp(['There are ',num2str(length(a)),' flights assigned in total'])
disp(['There are ',num2str(length(b2)),' gates used in total'])

