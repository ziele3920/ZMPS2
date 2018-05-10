close all; clear; clc;

rakiFCIRC = ReadRaki('F', 'CIRC');
imageNo = 4;
processedImage = rakiFCIRC(imageNo).image;
[I, mask] = CutCyc(processedImage);
I = uint8(I);


th = max(I(:))/1.5;
I(I<th) = 0;
arr = I(:);
arr = sort(arr);
minV = 0;
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
subplot(122); imshow(I);

classesNo = 6;
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
I2 = paseczkowanieWFORZE(I_median30, 1024, 64, [16 16]);
I3 = paseczkowanieWFORZE(I_median30, 64, 1024, [16 16]);
%I2 = double(blockproc(I_median30, [16 16], funKmeans));

%Id = double(I_median30(:));
%Ind = kmeans(Id, classesNo);
%I2 = reshape(Ind, [size(I_median30, 1) size(I_median30, 2)]);

%I2 = blockproc(I2, [blockWidthV blockHeightV], funKmeans);
figure;
subplot(221); imshow(uint8(I_median30));
subplot(222); imagesc(I2);
subplot(224); imagesc(I3);
%subplot(122); imshow(I2);