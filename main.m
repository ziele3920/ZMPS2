close all; clear; clc;

rakiFCIRC = ReadRaki('F', 'CIRC');

[I, mask] = CutCyc(rakiFCIRC(5).image);
I = uint8(I);

classesNo = 5;
funKmeans = @(block_struct) kMeans(block_struct.data, classesNo);
fun_contrast = @ (struktura_bloku) GLCM_contrast(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_corr = @ (struktura_bloku) GLCM_corr(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_energy = @ (struktura_bloku) GLCM_energy(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_homogenity = @ (struktura_bloku) GLCM_homogenity(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_entropy = @ (struktura_bloku) entropy(struktura_bloku.data)*ones(size(struktura_bloku.data));
fun_barEnergy = @ (struktura_bloku) barsEnergy(struktura_bloku.data)*ones(size(struktura_bloku.data));


%I_median30 = wiener2(I, [15 15]);
loverValue = 20;
higherVaule = 1024;
blockWidthH = loverValue;
blockHeightH = higherVaule;
blockWidthV = higherVaule;
blockHeightV = loverValue;
%I2 = blockproc(I_median30, [blockWidthH blockHeightH], fun_contrast);
I2 = paseczkowanieWFORZE(I, 1024, 48, [16 16]);
%I2 = double(blockproc(I, [16 16], fun_corr));

%I2 = blockproc(I2, [blockWidthV blockHeightV], funKmeans);
figure;
subplot(121); imshow(uint8(I));
subplot(122); imshow(I2);