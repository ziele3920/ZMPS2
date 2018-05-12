function [breastImg, mask] = CutBackground(image)
%Algorytm Raka ma byæ funkcja
%single image feom MIAS database
k = 2;

Id = double(image(:));
Ind = kmeans(Id, k);
Ind = reshape(Ind, [size(image, 1) size(image, 2)]);

%figure; imagesc(Ind);

backround_color = Ind(1,1);
mask_background = Ind;
mask_background(mask_background == backround_color) = 0;
mask_background(mask_background ~= 0) = 1;
no_background_image = (double(image) .* mask_background);

%figure; imagesc(no_background_image);

k1 = 4;
Id2 = double(no_background_image(:));
Ind2 = kmeans(Id2, k1);
Ind2 = reshape(Ind2, [size(image, 1) size(image, 2)]);
[maxValue, linearIndexesOfMaxes] = max(no_background_image(:));
[rowsOfMaxes, colsOfMaxes] = find(no_background_image == maxValue);
maxValueClassNuber = Ind2(rowsOfMaxes(1), colsOfMaxes(1));

mask_arm = Ind2;
mask_arm(mask_arm == maxValueClassNuber) = 0;
mask_arm = mask_arm .* mask_background;
mask_arm = imfill(mask_arm, 'holes');
mask_arm(mask_arm ~= 0) = 1;
mask = mask_arm;

breastImg = double(image) .* mask_arm;
breastImg = uint8(breastImg);
%figure; imagesc(Ind2);
%figure; imagesc(mask_arm);
%figure; imagesc(cutCyc);

end

