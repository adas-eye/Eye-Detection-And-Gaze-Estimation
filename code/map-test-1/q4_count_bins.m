% expects a double (0 to 1) image
function [cone_counts, non_cone_counts] = q4_count_bins(img, map, mask)

bin_size = 16;

cone_counts = zeros(256/bin_size,256/bin_size,256/bin_size);
non_cone_counts = zeros(256/bin_size,256/bin_size,256/bin_size);

pixels = reshape(img, [size(img,1)*size(img,2) size(img,3)]);
pixels = double(pixels) ./ repmat(sqrt(sum(pixels.^2, 2)), [1 3]);
pixels(isnan(pixels)) = 0;
is_cone = reshape(map, [numel(pixels)/3 1]);
pixels = pixels(find(mask(:)), :);
is_cone = is_cone(find(mask(:)));

bins = floor(pixels*255/bin_size)+1;
for i = 1:length(pixels)
    if is_cone(i) && norm(double(pixels(i,:))) > 0.1
        cone_counts(bins(i,1),bins(i,2),bins(i,3)) = ...
            cone_counts(bins(i,1),bins(i,2),bins(i,3)) + 1;
    else
        non_cone_counts(bins(i,1),bins(i,2),bins(i,3)) = ...
            non_cone_counts(bins(i,1),bins(i,2),bins(i,3)) + 1;
    end
end