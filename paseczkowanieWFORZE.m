function out = paseczkowanieWFORZE(img)

blockWidht = int32(1024);
blockHeight = int32(20);
iterations = int32(size(img, 1)/blockHeight);
out = img;
for i=1:iterations
    currentBockLowerHeight = (i-1)*blockHeight;
    currentBlockUpperHeight = i*blockHeight;
    if(currentBockLowerHeight == 0)
        currentBockLowerHeight = 1;
    end
    out(currentBockLowerHeight : currentBlockUpperHeight, 1:blockWidht) = barsEnergy(img(currentBockLowerHeight : currentBlockUpperHeight, 1:blockWidht));
end

