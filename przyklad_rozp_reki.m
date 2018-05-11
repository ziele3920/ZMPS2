close all; clear; clc; %wst�pne przygotowanie obszaru roboczego

%wyszukiwanie obraz�w o zadanych parametrach
rakiFCIRC = SearchCancer('F', 'CIRC');

%p�tla g��wna programu
figure;
for ri = 1 : 1
    imageNo = ri;
    processedImage = rakiFCIRC(imageNo).image;
    subplot(1,2,ri); imshow(processedImage);
    [I, mask] = onlyBreast(processedImage);
    I = uint8(I);
    subplot(1,2,ri+1); imshow(I);
end