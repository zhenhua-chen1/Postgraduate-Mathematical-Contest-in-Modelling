function Aij=flight2Aij(temp_flight)
J=length(temp_flight);
I=max(temp_flight(:,5));
Aij=ones(I,J);
    for j=1:J
        Aij(temp_flight(j,5),j)=0;
    end
end