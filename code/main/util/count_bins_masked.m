% counts # pixels in each rgb bin
function [bin_counts] = count_bins_masked(bin_size, img, mask)

    num_bins = 256/bin_size;
    bin_counts = zeros(num_bins,num_bins,num_bins);

    pixels = reshape(img, length(img(:,1,1)) * length(img(1,:,1)), 3);
    pixels = pixels(find(mask(:)), :);

    bins = floor(pixels*255/bin_size)+1;
    for i = 1:length(pixels)
        bin_counts(bins(i,1),bins(i,2),bins(i,3)) = ...
                bin_counts(bins(i,1),bins(i,2),bins(i,3)) + 1;
    end

end