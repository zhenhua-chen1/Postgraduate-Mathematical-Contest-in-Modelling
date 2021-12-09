function [mt,supply_oil,c1_t,Re_i,t]=box_value(box_i,mt,supply_oil,c1_t,Re_i,t1,epsilon)
load data
temp_consum_eng=consum_eng(t1:t1+59);
if temp_consum_eng(end)~=0
    T_max=59;
else
    temp_consum_eng(find(temp_consum_eng==0))=[];
    T_max=length(temp_consum_eng);
end

%% 一个箱子的供油
sbwm=consum_eng(t1:t1+T_max);;%傻逼王猛保存临时供油量
num_i=length(box_i);
if num_i==1
   if (sum(consum_eng(t1:t1+T_max))<=Re_i(box_i))&& prod(consum_eng(t1:t1+T_max)<=U_i(box_i))%判断供油量是否小于剩余油量
        for t=1:T_max+1
            Re_i(box_i)=Re_i(box_i)-sbwm(t);
            [x,y,z] = oCenter(Re_i);
            c1_t(t1+t-1,:)=[x,y,z]; 
            mt(t1+t-1)=Deviation([x,y,z] ,t1+t-1);
            supply_oil(t1+t-1,box_i)=sbwm(t);
        end
    end
end

if num_i==2
     if (ismember(1,box_i(1))&& ismember(2,box_i(2)))|| (ismember(6,box_i(1))&& ismember(5,box_i(2)))%1给2供油,2给发动机供油
        if (sum(consum_eng(t1:t1+T_max))<=Re_i(box_i(1)))&& prod(consum_eng(t1:t1+T_max)<=U_i(box_i(2)))&& prod(consum_eng(t1:t1+T_max)<=U_i(box_i(2)))
            for t=1:T_max+1
                Re_i(box_i(1))=Re_i(box_i(1))-sbwm(t);
                [x,y,z] = oCenter(Re_i);
                c1_t(t1+t-1,:)=[x,y,z];
                mt(t1+t-1)=Deviation([x,y,z] ,t1+t-1);
                supply_oil(t1+t-1,box_i(1))=sbwm(t);
                supply_oil(t1+t-1,box_i(2))=sbwm(t);
            end                
        end
    elseif (ismember(1,box_i(1))&& ~ismember(2,box_i(2)))|| (ismember(6,box_i(1))&& ~ismember(5,box_i(2)))%1给2供油,2不给发动机供油
        if (epsilon*60<=Re_i(box_i(1)))&&(sum(consum_eng(t1:t1+T_max))<=Re_i(box_i(2)))&& prod(consum_eng(t1:t1+T_max)<=U_i(box_i(2)))
            for t=1:T_max+1
                Re_i(box_i(1))=Re_i(box_i(2))-epsilon;
                supply_oil(t1+t-1,box_i(1))=epsilon;
                if box_i(1)==1
                    Re_i(2)=Re_i(2)+epsilon;
                else
                    Re_i(5)=Re_i(5)+epsilon;
                end
                Re_i(box_i(2))=Re_i(box_i(1))-sbwm(t);
                [x,y,z] = oCenter(Re_i);
                c1_t(t1+t-1,:)=[x,y,z];
                mt(t1+t-1)=Deviation([x,y,z] ,t1+t-1);
                supply_oil(t1+t-1,box_i(2))=sbwm(t);
            end  
        end
    else
        if (0.5*sum(consum_eng(t1:t1+T_max))<=Re_i(box_i(1)))&&(0.5*sum(consum_eng(t1:t1+T_max))<=Re_i(box_i(2)))&& prod(0.5*consum_eng(t1:t1+T_max)<=U_i(box_i(1)))&&prod(0.5*consum_eng(t1:t1+T_max)<=U_i(box_i(1)))
            for t=1:T_max+1
                Re_i(box_i(1))=Re_i(box_i(1))-0.5*sbwm(t);
                Re_i(box_i(2))=Re_i(box_i(2))-0.5*sbwm(t);
                supply_oil(t1+t-1,box_i(1))=0.5*sbwm(t);
                supply_oil(t1+t-1,box_i(2))=0.5*sbwm(t);
                [x,y,z] = oCenter(Re_i);
                c1_t(t1+t-1,:)=[x,y,z];
                mt(t1+t-1)=Deviation([x,y,z] ,t1+t-1);
            end
        end
     end
end
     
if num_i==3    
 if (ismember(box_i(2),[2,5]))&&(ismember(box_i(3),[1,6]))%第一个箱子给第二个箱子供油，第二个箱子向发动机供油；第三个箱子向其他箱子供油，但那个箱子不供油
        if (sum(consum_eng(t1:t1+T_max))<=Re_i(box_i(1)))&& prod(consum_eng(t1:t1+T_max)<=U_i(box_i(1)))&& (epsilon*60<=Re_i(box_i(3)))
            for t=1:T_max+1
                Re_i(box_i(1))=Re_i(box_i(1))-sbwm(t);
                Re_i(box_i(3))=Re_i(box_i(3))-epsilon;
                supply_oil(t1+t-1,box_i(1))=sbwm(t);
                supply_oil(t1+t-1,box_i(2))=sbwm(t);
                supply_oil(t1+t-1,box_i(3))=epsilon;
                if box_i(3)==1
                    Re_i(2)=Re_i(2)+epsilon;
                else
                    Re_i(5)=Re_i(5)+epsilon;
                end
                [x,y,z] = oCenter(Re_i);
                c1_t(t1+t-1,:)=[x,y,z];
                mt(t1+t-1)=Deviation([x,y,z] ,t1+t-1);
            end
        end
    elseif (ismember(box_i(2),[2,5]))&&~(ismember(box_i(3),[1,6]))
        if (0.5*sum(consum_eng(t1:t1+T_max))<=Re_i(box_i(1)))&&(0.5*sum(consum_eng(t1:t1+T_max))<=Re_i(box_i(3)))&& prod(0.5*consum_eng(t1:t1+T_max)<=U_i(box_i(1)))&&prod(0.5*consum_eng(t1:t1+T_max)<=U_i(box_i(3)))
            for t=1:T_max+1
                Re_i(box_i(1))=Re_i(box_i(1))-0.5*sbwm(t);
                Re_i(box_i(3))=Re_i(box_i(3))-0.5*sbwm(t);
                supply_oil(t1+t-1,box_i(1))=0.5*sbwm(t);
                supply_oil(t1+t-1,box_i(2))=0.5*sbwm(t);
                supply_oil(t1+t-1,box_i(3))=0.5*sbwm(t);
                [x,y,z] = oCenter(Re_i);
                c1_t(t1+t-1,:)=[x,y,z];
                mt(t1+t-1)=Deviation([x,y,z] ,t1+t-1);
            end
        end
    elseif ~(ismember(box_i(2),[2,5]))&&~(ismember(box_i(3),[1,6]))
        if (epsilon*60<=Re_i(box_i(1)))&&(0.5*sum(consum_eng(t1:t1+T_max))<=Re_i(box_i(2)))&&(0.5*sum(consum_eng(t1:t1+T_max))<=Re_i(box_i(3)))&& prod(0.5*consum_eng(t1:t1+T_max)<=U_i(box_i(2)))&&prod(0.5*consum_eng(t1:t1+T_max)<=U_i(box_i(3)))
            for t=1:T_max+1
                Re_i(box_i(2))=Re_i(box_i(2))-0.5*sbwm(t);
                Re_i(box_i(3))=Re_i(box_i(3))-0.5*sbwm(t);
                Re_i(box_i(1))=Re_i(box_i(1))-epsilon;
                supply_oil(t1+t-1,box_i(1))=epsilon;
                supply_oil(t1+t-1,box_i(2))=0.5*sbwm(t);
                supply_oil(t1+t-1,box_i(3))=0.5*sbwm(t);
                if box_i(1)==1
                    Re_i(2)=Re_i(2)+epsilon;
                else
                    Re_i(5)=Re_i(5)+epsilon;
                end
                [x,y,z] = oCenter(Re_i);
                c1_t(t1+t-1,:)=[x,y,z];
                mt(t1+t-1)=Deviation([x,y,z] ,t1+t-1);
            end
        end
    else
        if  (sum(consum_eng(t1:t1+T_max))<=Re_i(box_i(2)))&& prod(consum_eng(t1:t1+T_max)<=U_i(box_i(2)))&& (epsilon*60<=Re_i(box_i(1))) && (epsilon*60<=Re_i(box_i(3)))
            for t=1:T_max+1
                Re_i(box_i(1))=Re_i(box_i(1))-epsilon;
                Re_i(box_i(3))=Re_i(box_i(3))-epsilon;
                Re_i(2)=Re_i(2)+epsilon;
                Re_i(5)=Re_i(5)+epsilon;
                Re_i(box_i(2))=Re_i(box_i(2))-sbwm(t);
                supply_oil(t1+t-1,box_i(1))=epsilon;
                supply_oil(t1+t-1,box_i(2))=sbwm(t);
                supply_oil(t1+t-1,box_i(3))=epsilon;                
                [x,y,z] = oCenter(Re_i);
                c1_t(t1+t-1,:)=[x,y,z];
                mt(t1+t-1)=Deviation([x,y,z] ,t1+t-1);
            end
        end
    end
end
t=t1+T_max;
end