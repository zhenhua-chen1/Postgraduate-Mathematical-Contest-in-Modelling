function j_new=is_coflict(i,J,temp_Cij,Z,Bii)
j_new=[];
flag=1;
for j=J
    for i2=1:Z
        if i~=i2
            if temp_Cij(i2,j)==1%看是否被选择过
                if Bii(i,i2)==0%i1与i2小于45分钟
                    flag=0;
                    break
                end
            end
        end
    end
    if flag==1
        j_new=[j_new,j];
    end
        
end
end