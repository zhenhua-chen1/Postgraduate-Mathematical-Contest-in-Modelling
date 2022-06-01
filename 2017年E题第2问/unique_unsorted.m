function uniVecUnsorted = unique_unsorted(vector)
uniValues = unique (vector);
mask=zeros(size(vector,1),size(vector,2));
for i=1:length(uniValues)
    maskValue=(vector==uniValues(i));
    indFirst=find(vector==uniValues(i),1,'first');
    maskValue(indFirst+1:end)=0;
    mask=mask|maskValue;
end
uniVecUnsorted=vector(mask);
end 