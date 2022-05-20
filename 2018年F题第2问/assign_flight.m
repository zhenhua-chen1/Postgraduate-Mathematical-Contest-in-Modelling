    function Cij=assign_flight(Cij)
        load data
        for i1=1:Z
            if sum(Cij(i1,:)==1)==0
                % used gates in front
                [~,b]=find(Cij==1);
                b=unique(b);
                N_1=1:N;
                N_1(b)=[];
                N_1=[b',N_1];
                for j=N_1
                    flag=ones(Z,1);
                    if Aij(i1,j)==1
                        % Is i1 in conflict with other at  j
                        for i2=1:Z
                            if i1~=i2
                                if Cij(i2,j)==1% See if it has been selected
                                    if Bii(i1,i2)==0% i1 & i2 less than 45 minutes
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