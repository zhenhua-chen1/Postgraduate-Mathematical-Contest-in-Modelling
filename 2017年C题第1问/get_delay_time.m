function [f,Aij_time]=get_delay_time(Aij)
    load data
    Aij=~Aij;
    [n_a,n_f]=size(Aij);
    Aij_time=zeros(n_a,n_f);
    delay_stime=1461348000;
    delay_etime=1461358800;
    dalay_timea=0;
    temp_flights=flights;
    for i=1:n_a
        for j=1:n_f
            if Aij(i,j)
                if flights(j,3)==1 && delay_stime<=temp_flights(j,1) && delay_etime>=temp_flights(j,1)
                    [temp_flights,Aij_time]=get_time(i,j,temp_flights,delay_etime,Aij,Aij_time,1);
                elseif flights(j,4)==1 && delay_stime<=temp_flights(j,2) && delay_etime>=temp_flights(j,2)
                    [temp_flights,Aij_time]=get_time(i,j,temp_flights,delay_etime,Aij,Aij_time,0);
                end
            end
        end
    end
f=sum(sum(Aij_time));
end
function [temp_flights,Aij_time]=get_time(i,j,temp_flights,delay_etime,Aij,Aij_time,is_fly)
              if is_fly
                  delayTemp=delay_etime-temp_flights(j,1);
                  temp_flights(j,1)=delay_etime;
                  temp_flights(j,2)=temp_flights(j,2)+delayTemp;
              else
                  delayTemp=delay_etime-temp_flights(j,2);
                  temp_flights(j,2)=delay_etime;
                  temp_flights(j,1)=temp_flights(j,2)+delayTemp;
              end
              Aij_time(i,j)=delayTemp;
              [~,nf]=size(Aij);
              for f=j:nf
                  if Aij(i,f)
                       if temp_flights(f,1)-temp_flights(j,2)<45*60
                           delayTemp= 45*60-temp_flights(f,1)+temp_flights(j,2);
                           temp_flights(f,1)=temp_flights(f,1)+(delayTemp);
                           temp_flights(f,2)=temp_flights(f,2)+(delayTemp);
                           Aij_time(i,f)=delayTemp;
                       else
                           break
                       end
                  end
              end
              
end