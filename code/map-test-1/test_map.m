clear; close all;

load('is_eye.mat');

files = dir('../eyes/');
imgs = {};
for i = 4:length(files)
    if strcmp(files(i).name, '.') || strcmp(files(i).name, '..')
        continue
    end
    fname = files(i).name
    imgs = [imgs, ...
        imread(strcat('../eyes/', fname))];
end

front_img = im2double(imresize(imread(strcat('../eyes/', files(3).name)), 0.5));

% testing

for im_idx = 1%:5%1:30

    test = imresize(im2double(imgs{im_idx}), 0.5);
    
    figure;
    subplot(1,2,1); imshow(test);
    subplot(1,2,2); 

    eyes = find_eyes(is_cone, bin_size, test);

    imshow(0.5*test + repmat(double(eyes), [1 1 3]));
    
    model = q4_sift_match(0, single(front_img), single(test));
    idxs = find(eyes);
    [js, is] = ind2sub(size(eyes), idxs);
    newpos = zeros(3,1);
    for t = 1:length(is)
        pos = [is(t) js(t) 1]'
        posp = model.model * pos
        newpos(:,t) = posp;
    end
    figure; imshow(front_img); hold on;
    plot(newpos(1,:), newpos(2,:), 'o');
    
    
    
    %idxs = find(face_pixels);
% ind2sub(idxs, size(face_pixels));
% [is, js] = ind2sub(size(face_pixels), idxs);
% K = convhull(is, js);
% mask = roipoly(face_pixels, js(K), is(K));

end