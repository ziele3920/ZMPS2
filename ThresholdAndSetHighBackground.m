function result = ThresholdAndSetHighBackground( I, thDivider )

%thresholdinh
th = max(I(:))/thDivider;
I(I<th) = 0;

%rise background
arr = I(:);
arr = sort(arr);minV = 0;
for ii=1:length(arr)
    if arr(ii) == 0
        continue;
    end
    minV = arr(ii);
    break;
end
I(I == 0) = minV;
result = I;

end

