close all; clear; clc;

rakiFCIRC = ReadRaki('F', 'CIRC');
for ri = 1 : 14
imageNo = ri;
processedImage = rakiFCIRC(imageNo).image;
[I, mask] = CutCyc(processedImage);
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
%figure; plot(arr);
for ii=1:length(arr)
    if arr(ii) == 0
        continue;
    end
    minV = arr(ii);
    break;
end
I(I == 0) = minV;
I = imadjust(I);

%aff = sort(I(:));
%se = strel('disk',3);
%I = imopen(I,se);
%I = imerode(I, se);

figure; subplot(121); imshow(rakiFCIRC(imageNo).image); 
viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
subplot(122); imshow(I);
viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
title(num2str(ri));

classesNo = 2;
funKmeans = @(block_struct) kMeans(block_struct.data, classesNo);
fun_contrast = @ (struktura_bloku) GLCM_contrast(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_corr = @ (struktura_bloku) GLCM_corr(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_energy = @ (struktura_bloku) GLCM_energy(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_homogenity = @ (struktura_bloku) GLCM_homogenity(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_entropy = @ (struktura_bloku) entropy(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_barEnergy = @ (struktura_bloku) barsEnergy(struktura_bloku.data)*ones(size(struktura_bloku.data));


I_median30 = wiener2(I, [20 20]);
loverValue = 20;
higherVaule = 1024;
blockWidthH = loverValue;
blockHeightH = higherVaule;
blockWidthV = higherVaule;
blockHeightV = loverValue;
%I2 = blockproc(I_median30, [blockWidthH blockHeightH], fun_contrast);
%I2 = paseczkowanieWFORZE(I_median30, 1024, 64, [16 16]);
%I3 = paseczkowanieWFORZE(I_median30, 64, 1024, [16 16]);
I2 = double(blockproc(I_median30, [60 1024], funKmeans));
I3 = double(blockproc(I_median30, [1024 60], funKmeans));

%Id = double(I_median30(:));
%Ind = kmeans(Id, classesNo);
%I2 = reshape(Ind, [size(I_median30, 1) size(I_median30, 2)]);

%I2 = blockproc(I2, [blockWidthV blockHeightV], funKmeans);
figure;
subplot(221); imshow(uint8(I_median30));
viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
subplot(222); imagesc(I2);
viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
subplot(224); imagesc(I3);
viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
%subplot(122); imshow(I2);
end