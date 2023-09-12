function pos = iscut(L,H,S) 
min_l = min(S(:,1));
min_h = min(S(:,2));
if min_l<L && min_h<H
    pos = 1;
else
    pos = 0;
end
end