function mt=Deviation(c1_t)
load data
    mt=sqrt((c1_t(1)-c0_t(1))^2+(c1_t(2)-c0_t(2))^2+(c1_t(3)-c0_t(3))^2);
end
