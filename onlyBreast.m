function [onlyBreastImage, mask] = onlyBreast(image)
% Algorytm na wejœciu przyjmuje obraz, a na wyjœciu zwraca obraz
% przerobiony oraz maskê

k = 2; %iloœæ klas dla metody k-œrednich

%Zastosowanie metody k-œrednich do obrazu w celu usuniêcia z niego t³a
Id = double(image(:));
Ind = kmeans(Id, k);
Ind = reshape(Ind, [size(image, 1) size(image, 2)]);

%Ze wzglêdu na losowoœæ przydzielania klas, okaza³o siê potrzebne
%wyszukanie klasy t³a, które realizuje siê poprzez znalezienie klasy
%pierwszego piksela obrazu, który na wszystkich zdjêciach ma zawsze kolor
%t³a
backround_color = Ind(1,1);
mask_background = Ind;
mask_background(mask_background == backround_color) = 0;
mask_background(mask_background ~= 0) = 1;
no_background_image = (double(image) .* mask_background);

%Ponowne u¿ycie algorytmu k-œrednich, tym razem w celu usuniêcia rêki z
%obrazu.
k1 = 4; %iloœæ klas
Id2 = double(no_background_image(:));
Ind2 = kmeans(Id2, k1);
Ind2 = reshape(Ind2, [size(image, 1) size(image, 2)]);
[maxValue] = max(no_background_image(:));
[rowsOfMaxes, colsOfMaxes] = find(no_background_image == maxValue);
maxValueClassNuber = Ind2(rowsOfMaxes(1), colsOfMaxes(1));

%Koñcowe operacje ró¿nicowania obrazu od wykrytych pól
mask_arm = Ind2;
mask_arm(mask_arm == maxValueClassNuber) = 0;
mask_arm = mask_arm .* mask_background;
mask_arm = imfill(mask_arm, 'holes');
mask_arm(mask_arm ~= 0) = 1;
mask = mask_arm;
onlyBreastImage = double(image) .* mask_arm;
end

