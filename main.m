close all; clear; clc;

rakiFCIRC = LoadImages('F', 'CIRC');
for ri = 4 : 4
    imageNo = ri;
    processedImage = rakiFCIRC(imageNo).image;

    [I, mask] = CutBackground(processedImage);
    I = ThresholdAndSetHighBackground(I, 1.4);

    I32 = double(I);
    I32 = I32 * 255;

    I32 = CutUpperValues(I32, 20);
    I = NormalizeImg(I32);
    I = imadjust(I);

    %morphological
    %aff = sort(I(:));
    %se = strel('disk',3);
    %I = imopen(I,se);
    %I = imerode(I, se);

    classesNo = 3;
    funKmeans = @(block_struct) kMeans(block_struct.data, classesNo);

    I_median30 = wiener2(I, [20 20]);
    blockWidth = 60;
    imgSize = 1024;
    %I2 = blockproc(I_median30, [blockWidthH blockHeightH], fun_contrast);
    %I2 = paseczkowanieWFORZE(I_median30, 1024, 64, [16 16]);
    %I3 = paseczkowanieWFORZE(I_median30, 64, 1024, [16 16]);
    I2 = double(blockproc(I_median30, [blockWidth imgSize], funKmeans));
    I3 = double(blockproc(I_median30, [imgSize blockWidth], funKmeans));

    figure; subplot(121); imshow(rakiFCIRC(imageNo).image); 
    title(['Oryginalny obraz ' rakiFCIRC(imageNo).fileName]);
    viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
    subplot(122); imshow(I);
    title(['Wstêpnie przetworzony obraz ' rakiFCIRC(imageNo).fileName]);
    viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));

    figure;
    subplot(221); imshow(uint8(I_median30));
    title(['Wstêpnie przetworzony obraz ' rakiFCIRC(imageNo).fileName ' po filtracji']);
    viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
    subplot(222); imagesc(I2);
    title('Klasteryzacja k-œrednich w segmentach poziomych');
    viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
    subplot(224); imagesc(I3);
    title('Klasteryzacja k-œrednich w segmentach pionowych');
    viscircles([rakiFCIRC(imageNo).rakCircle(1) 1024 - rakiFCIRC(imageNo).rakCircle(2)], rakiFCIRC(imageNo).rakCircle(3));
end