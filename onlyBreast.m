function [onlyBreastImage, mask] = onlyBreast(image)
% Algorytm na wej�ciu przyjmuje obraz, a na wyj�ciu zwraca obraz
% przerobiony oraz mask�

k = 2; %ilo�� klas dla metody k-�rednich

%Zastosowanie metody k-�rednich do obrazu w celu usuni�cia z niego t�a
Id = double(image(:));
Ind = kmeans(Id, k);
Ind = reshape(Ind, [size(image, 1) size(image, 2)]);

%Ze wzgl�du na losowo�� przydzielania klas, okaza�o si� potrzebne
%wyszukanie klasy t�a, kt�re realizuje si� poprzez znalezienie klasy
%pierwszego piksela obrazu, kt�ry na wszystkich zdj�ciach ma zawsze kolor
%t�a
backround_color = Ind(1,1);
mask_background = Ind;
mask_background(mask_background == backround_color) = 0;
mask_background(mask_background ~= 0) = 1;
no_background_image = (double(image) .* mask_background);

%Ponowne u�ycie algorytmu k-�rednich, tym razem w celu usuni�cia r�ki z
%obrazu.
k1 = 4; %ilo�� klas
Id2 = double(no_background_image(:));
Ind2 = kmeans(Id2, k1);
Ind2 = reshape(Ind2, [size(image, 1) size(image, 2)]);
[maxValue] = max(no_background_image(:));
[rowsOfMaxes, colsOfMaxes] = find(no_background_image == maxValue);
maxValueClassNuber = Ind2(rowsOfMaxes(1), colsOfMaxes(1));

%Ko�cowe operacje r�nicowania obrazu od wykrytych p�l
mask_arm = Ind2;
mask_arm(mask_arm == maxValueClassNuber) = 0;
mask_arm = mask_arm .* mask_background;
mask_arm = imfill(mask_arm, 'holes');
mask_arm(mask_arm ~= 0) = 1;
mask = mask_arm;
onlyBreastImage = double(image) .* mask_arm;
end

