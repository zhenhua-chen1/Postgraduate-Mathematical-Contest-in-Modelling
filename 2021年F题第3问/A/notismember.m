function [I2,I]=notismember(path1,I)

I(path1)=1;
I2=find(I==0);
end