close all; clear; clc;

rakiFCIRC = ReadRaki('F', 'CIRC');

[I, mask] = CutCyc(rakiFCIRC(5).image);


classesNo = 5;
funKmeans = @(block_struct) kMeans(block_struct.data, classesNo);
fun_contrast = @ (struktura_bloku) GLCM_contrast(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_corr = @ (struktura_bloku) GLCM_corr(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_energy = @ (struktura_bloku) GLCM_energy(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_homogenity = @ (struktura_bloku) GLCM_homogenity(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_entropy = @ (struktura_bloku) entropy(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_barEnergy = @ (struktura_bloku) barsEnergy(struktura_bloku.data)*ones(size(struktura_bloku.data));

%I = I.^2;
%I = (I - min(I)) ./ ( max(I) - min(I) ) .* 255;
%I(isnan(I)) = 0;
%figure; imshow(uint8(I));
%boxKernel = ones(5,5); % Or whatever size window you want.
%I = conv2(I, boxKernel, 'same');
%I = (I - min(I)) ./ ( max(I) - min(I) ) .* 255;
%I(isnan(I)) = 0;
%figure; imshow(uint8(I));

%prepocessing
%median filter
%I_median3 = wiener2(I, [6 6]);
%I_median6 = medfilt2(I, [30 30]);
I_median30 = wiener2(I, [30 30]);

%figure;
%subplot(221); imshow(uint8(I)); title('originial image');
%subplot(222); imshow(uint8(I_median3)); title('median filtered image 3');
%subplot(223); imshow(uint8(I_median6)); title('median filtered image 6');
%subplot(224); imshow(uint8(I_median30)); title('median filtered image 30');
loverValue = 20;
higherVaule = 1024;
blockWidthH = loverValue;
blockHeightH = higherVaule;
blockWidthV = higherVaule;
blockHeightV = loverValue;
%I2 = blockproc(I_median30, [blockWidthH blockHeightH], fun_barEnergy);
I2 = paseczkowanieWFORZE(I_median30);
%I2 = blockproc(I2, [blockWidthV blockHeightV], funKmeans);
figure;
subplot(121); imshow(uint8(I_median30));
subplot(122); imagesc(I2);
%I_homo = double(blockproc(I_median30, [blockWidthH blockHeightH], fun_corr));
%I_HV = double(blockproc(I_median30, [blockWidthV blockHeightV], fun_energy));
%I_HM = I_homo .* I_HV;
%I_HM = (I_HM - min(I_HM))/(max(I_HM) - min(I_HM));

%figure;
%subplot(221); imagesc(I_homo)
%subplot(222); imagesc(I_HV);
%subplot(223); imagesc(I_HM);
%subplot(224); imshow(uint8(I))