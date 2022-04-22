    function Cij=assign_flight(Cij)
        load data
        for i1=1:Z
            if sum(Cij(i1,:)==1)==0
                % 使用过的登机口放前面
                [~,b]=find(Cij==1);
                b=unique(b);
                N_1=1:N;
                N_1(b)=[];
                N_1=[b',N_1];
                for j=N_1
                    %          if sum(Cij(i1,:))==0 %i1是否被选择过
                    flag=ones(Z,1);
                    if Aij(i1,j)==1
                        % 在j点i1与其他是否冲突
                        for i2=1:Z
                            if i1~=i2
                                if Cij(i2,j)==1%看是否被选择过
                                    if Bii(i1,i2)==0%i1与i2小于45分钟
                                        flag(i2)=0;
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
        end
    end