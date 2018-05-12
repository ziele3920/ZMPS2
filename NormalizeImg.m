function result = NormalizeImg( I32 )

maxExpected = 255;
min32 = min(I32(:));
minExpected = min32/max(I32(:)) * 255;
I32 = (I32 - min32) * (maxExpected - minExpected)/(max(I32(:)) - min32) + minExpected;
result = uint8(I32);

end

