function result = kMeans(image, classesNo)

Id = double(image(:));
result = kmeans(Id, classesNo);
result = reshape(result, [size(image,1) size(image,2)]);
end

