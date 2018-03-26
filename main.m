close all; clear; clc;

rakiFCIRC = ReadRaki('F', 'CIRC');

[I, mask] = CutCyc(rakiFCIRC(3).image);


classesNo = 4;
funKmeans = @(block_struct) kMeans(block_struct.data, classesNo);

I = I.^2;
I = (I - min(I)) ./ ( max(I) - min(I) ) .* 255;
I(isnan(I)) = 0;
figure; imshow(uint8(I));
boxKernel = ones(5,5); % Or whatever size window you want.
I = conv2(I, boxKernel, 'same');
I = (I - min(I)) ./ ( max(I) - min(I) ) .* 255;
I(isnan(I)) = 0;
figure; imshow(uint8(I));
blockWidth = 50;
blockHeight = 1024;
I2 = blockproc(I, [blockWidth blockHeight], funKmeans);
figure;
imagesc(I2)
