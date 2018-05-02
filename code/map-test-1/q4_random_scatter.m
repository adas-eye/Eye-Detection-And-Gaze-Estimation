function q4_random_scatter(img, map, n)

[pixels, is_cone] = q4_random_samples(img, map, n);

scatter3(pixels(is_cone==0, 1), pixels(is_cone==0, 2), ...
    pixels(is_cone==0, 3), 5, 'g+'); hold on;

img_vect = reshape(img, [size(img,1)*size(img,2) 3]);
scatter3(img_vect(find(map),1), img_vect(find(map),2), img_vect(find(map),3), 10, 'bo');
xlabel('R'); ylabel('G'); zlabel('B');
