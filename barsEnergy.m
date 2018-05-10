function out = barsEnergy(img, blockSize)
    blockWidthV = 16;
    blockHeightV = 16;  
    classesNo = 4;
    fun_energy = @ (struktura_bloku) GLCM_energy(struktura_bloku.data)*ones(size(struktura_bloku.data));
    funKmeans = @(block_struct) kMeans(block_struct.data, classesNo);
    fun_contrast = @ (struktura_bloku) GLCM_contrast(struktura_bloku.data)*ones(size(struktura_bloku.data));
    fun_corr = @ (struktura_bloku) GLCM_corr(struktura_bloku.data)*ones(size(struktura_bloku.data));
    fun_energy = @ (struktura_bloku) GLCM_energy(struktura_bloku.data)*ones(size(struktura_bloku.data));
    fun_homogenity = @ (struktura_bloku) GLCM_homogenity(struktura_bloku.data)*ones(size(struktura_bloku.data));
    fun_entropy = @ (struktura_bloku) entropy(struktura_bloku.data)*ones(size(struktura_bloku.data));
    fun_barEnergy = @ (struktura_bloku) barsEnergy(struktura_bloku.data)*ones(size(struktura_bloku.data));

    out = double(blockproc(img, blockSize, fun_energy));
end

