% expects a uint8
function mask = find_face(img)

num_bins = 3;
bin_size = 256/num_bins;

% crop image to center-ish of face

[h, w, d] = size(img);
im_cropped = img(h/3:2*h/3,w/3:2*w/3,:);

bin_counts = count_bins(bin_size, im_cropped);

mean_color = mean(mean(im_cropped, 1), 2);

% now find the face

test = double(img);
test_sub = test - repmat(mean_color, [size(test,1) size(test,2) 1]);
test_norm = sqrt(sum(test_sub.^2, 3));

face_pixels = test_norm < 34/255;

face_pixels = imopen(face_pixels, ones(8));

% convex hullification

idxs = find(face_pixels);
ind2sub(idxs, size(face_pixels));
[is, js] = ind2sub(size(face_pixels), idxs);
K = convhull(is, js);
mask = roipoly(face_pixels, js(K), is(K));

end