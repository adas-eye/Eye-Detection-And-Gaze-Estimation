function classified = map_classify(is_pos, bin_size, img)
    
    img_norm = gray_normalize(img);
    binned = floor(img_norm*255 / bin_size)+1;
    binned(binned<1) = 1;
    classified = zeros(length(img_norm(:,1,1)), length(img_norm(1,:,1)));
    for i = 1:length(img_norm(:,1,1))
        for j = 1:length(img_norm(1,:,1))
            classified(i,j) = is_pos(binned(i,j,1), ...
                binned(i,j,2), binned(i,j,3));
        end
    end

end