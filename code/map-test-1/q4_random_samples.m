function [img_samples, map_samples] = q4_random_samples(img, map, n)

pixels = reshape(img, length(img(:,1,1)) * length(img(1,:,1)), 3);
map_pixels = reshape(map, length(pixels(:,1)), 1);
random_idx = randperm(length(map_pixels), n);
map_samples = map_pixels(random_idx);
img_samples = pixels(random_idx,:);