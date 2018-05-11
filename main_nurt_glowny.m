close all; clear; clc; %wstêpne przygotowanie obszaru roboczego

%wyszukiwanie obrazów o zadanych parametrach
rakiFCIRC = SearchCancer('F', 'CIRC');

%pêtla g³ówna programu

for ri = 1 : 1
    imageNo = ri;
    processedImage = rakiFCIRC(imageNo).image;
    [I, mask] = onlyBreast(processedImage);
    I = uint8(I);
    
    th = max(I(:))/1.4;
    I(I<th) = 0;
    I32 = double(I);
    I32 = I32 .* (I32 * 255);
    arr0 = I32(:);
    arr0 = sort(arr0);
    maxV = arr0(length(arr0));
    counter = 0;
    skipNo = 20;
    for i = length(arr0):-1:1
        if arr0(i) == maxV
            continue;
        end
        counter = counter + 1;
        maxV = arr0(i);
        if counter == skipNo
            break;
        end
    end
    I32(I32>maxV) = maxV;
    
    maxVv = 255;
    min32 = 0;
    for ii=1:length(arr0)
        if arr0(ii) == 0
            continue;
        end
        min32 = arr0(ii);
        break;
    end
    
    I32 = (I32 - min32)/(max(I32(:)) - min32) * maxVv;
    I32(I32 < 0) = 0;
    I = uint8(I32);
    
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
    I = imadjust(I);
    
    figure; subplot(121); imshow(rakiFCIRC(imageNo).image);
    viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
    subplot(122); imshow(I);
    viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
    title(num2str(ri));
    
    classesNo = 2; %liczba klas
    funKmeans = @(block_struct) kMeans(block_struct.data, classesNo);

    I_median30 = wiener2(I, [20 20]);
    loverValue = 20;
    higherVaule = 1024;
    blockWidthH = loverValue;
    blockHeightH = higherVaule;
    blockWidthV = higherVaule;
    blockHeightV = loverValue;
    I2 = double(blockproc(I_median30, [60 1024], funKmeans));
    I3 = double(blockproc(I_median30, [1024 60], funKmeans));
    
    figure;
    subplot(2,2,[1,3]); imshow(uint8(I_median30));
    viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
    subplot(222); imagesc(I2);
    viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
    subplot(224); imagesc(I3);
    viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
end