function out = barsEnergy(img)
    blockWidthV = 10;
    blockHeightV = 10;  
    fun_energy = @ (struktura_bloku) GLCM_energy(struktura_bloku.data)*ones(size(struktura_bloku.data));
    out = double(blockproc(img, [blockWidthV blockHeightV], fun_energy));
end

