function out = paseczkowanieWFORZE(img, barWidth, barHeight, blockSize)

barWidth = int32(barWidth);
barHeight = int32(barHeight);
if(barWidth > barHeight)
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
else 
    iterations = int32(size(img, 2)/barWidth);
    out = double(img);
    for i=1:iterations
       currentBockLowerWidth = (i-1)*barWidth;
       currentBlockUpperWidth = i*barWidth;
       if(currentBockLowerWidth == 0)
           currentBockLowerWidth = 1;
       end
       if(currentBlockUpperWidth > size(img, 2))
        currentBlockUpperWidth = size(img, 2);
       end
     out(1:barHeight, currentBockLowerWidth : currentBlockUpperWidth) = barsEnergy(img(1:barHeight, currentBockLowerWidth : currentBlockUpperWidth), blockSize);
    end
end

