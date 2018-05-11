close all; clear; clc; %wstêpne przygotowanie obszaru roboczego

%wyszukiwanie obrazów o zadanych parametrach
rakiFCIRC = SearchCancer('F', 'CIRC');

%pêtla g³ówna programu
figure;
for ri = 1 : 1
    imageNo = ri;
    processedImage = rakiFCIRC(imageNo).image;
    subplot(1,2,ri); imshow(processedImage);
    [I, mask] = onlyBreast(processedImage);
    I = uint8(I);
    subplot(1,2,ri+1); imshow(I);
end