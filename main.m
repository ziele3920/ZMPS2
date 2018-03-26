close all; clear; clc;

rakiFCIRC = ReadRaki('F', 'CIRC');
dupa = rakiFCIRC(1).image;
[I, mask] = CutCyc(rakiFCIRC(1).image);
figure; imshow(uint8(I));

%classesNo = 3;
%funKmeans = @(block_struct) kMeans(block_struct.data, classesNo);

%blockWidth = 20;
%blockHeight = 1024;
%I = kMeans(rakiFCIRC(1).image, 2);
%I2 = blockproc(I, [blockWidth blockHeight], funKmeans);
%figure;
%imagesc(I2)
