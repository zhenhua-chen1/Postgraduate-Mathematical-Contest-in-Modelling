function path=PathGenerate0(Rho2,o,~)
load data
Rho=Rho2;
path(1)=o;
i=o;
step=1;
while i~=I&&step<=I
    min_j=find(Rho(i,:)==1);
    for j=min_j
        if i<j
            if Rho(i,j)==1  %ÊÇ·ñ·ûºÏÔ¼Êø
                path=[path,j];
                i=j;
                break
            end
        end
    end
  step=step+1;  
end
end 