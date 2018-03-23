close all; clear; clc;

rakiFCIRC = ReadRaki('F', 'CIRC');

%classesNo = 3;
%funKmeans = @(block_struct) kMeans(block_struct, classesNo);

%blockWidth = 1024;
%blockHeight = 20;
%I = kMeans(rakiFCIRC(1).image, 2);
%I2 = blockproc(I, [blockWidth blockHeight], funKmeans);
%figure;
%imshow(I2)
