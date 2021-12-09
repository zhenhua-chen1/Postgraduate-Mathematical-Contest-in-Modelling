function mt=Deviation(c1_t,t)
load data
    mt=sqrt((c1_t(1)-c2_t(t,1))^2+(c1_t(2)-c2_t(t,2))^2+(c1_t(2)-c2_t(t,2))^2);
end
