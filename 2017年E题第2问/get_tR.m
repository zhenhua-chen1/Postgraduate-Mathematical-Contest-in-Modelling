function [RC,time_R]=get_tR(R_c,c2,k,RC,time_R)
load data
        RC(k,1:length(R_c))=R_c;%get the route;
        time_R1=c2(R_c);%get the time
        time_R(k,1:length(time_R1))=time_R1;
end