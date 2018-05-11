function result = CutUpperValues( I32, cutValuesCount )

arr0 = I32(:);
arr0 = sort(arr0);
maxV = arr0(length(arr0));
counter = 0;
for i = length(arr0):-1:1
    if arr0(i) == maxV
        continue;
    end
    counter = counter + 1;
    maxV = arr0(i);
    if counter == cutValuesCount
        break;
    end
end
arr = I32(:);
arr = sort(arr);minV = 0;
for ii=1:length(arr)
    if arr(ii) == 0
        continue;
    end
    minV = arr(ii);
    break;
end
I32(I32>maxV) = minV;
result = I32;

end

