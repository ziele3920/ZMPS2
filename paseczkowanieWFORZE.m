function out = paseczkowanieWFORZE(img, barWidth, barHeight, blockSize)

barWidth = int32(barWidth);
barHeight = int32(barHeight);
iterations = int32(size(img, 1)/barHeight);
out = double(img);
for i=1:iterations
    currentBockLowerHeight = (i-1)*barHeight;
    currentBlockUpperHeight = i*barHeight;
    if(currentBockLowerHeight == 0)
        currentBockLowerHeight = 1;
    end
    if(currentBlockUpperHeight > size(img, 1))
        currentBlockUpperHeight = size(img, 1);
    end
    out(currentBockLowerHeight : currentBlockUpperHeight, 1:barWidth) = barsEnergy(img(currentBockLowerHeight : currentBlockUpperHeight, 1:barWidth), blockSize);
end

