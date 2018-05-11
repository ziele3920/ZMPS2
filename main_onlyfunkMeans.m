close all; clear; clc; %wstêpne przygotowanie obszaru roboczego

%wyszukiwanie obrazów o zadanych parametrach
rakiFCIRC = SearchCancer('F', 'CIRC');

%pêtla g³ówna programu

for ri = 1 : 1
    imageNo = ri;
    processedImage = rakiFCIRC(imageNo).image;
    [I, mask] = onlyBreast(processedImage);
    I = uint8(I);
        
    classesNo = 20; %liczba klas
    funKmeans = @(block_struct) kMeans(block_struct.data, classesNo);

    I2 = double(blockproc(I, [60 1024], funKmeans));
    I3 = double(blockproc(I, [1024 60], funKmeans));
    
    figure;
    subplot(2,2,[1,3]); imshow(uint8(I));
    viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
    subplot(222); imagesc(I2);
    viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
    subplot(224); imagesc(I3);
    viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
end