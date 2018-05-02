% counts # pixels in each rgb bin
function [bin_counts] = count_bins(bin_size, img)

bin_counts = zeros(256/bin_size,256/bin_size,256/bin_size);

pixels = reshape(img, length(img(:,1,1)) * length(img(1,:,1)), 3);

bins = floor(abs(double(pixels)/bin_size))+1;
for i = 1:length(pixels)
    bin_counts(bins(i,1),bins(i,2),bins(i,3)) = ...
        bin_counts(bins(i,1),bins(i,2),bins(i,3)) + 1;
end

end