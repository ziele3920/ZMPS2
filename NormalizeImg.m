function result = NormalizeImg( I32 )

maxExpected = 255;
min32 = min(I32(:));
I32 = (I32 - min32)/(max(I32(:)) - min32) * maxExpected;
I32(I32 < 0) = 0;
result = uint8(I32);

end

