% JR = 30
% NHS = 42

close all;

for im_idx = 1:5%1:10

    figure;
    img = im2double(img_train{im_idx});
    imshow(0.5 * img + 0.2 * repmat(find_face(img), [1 1 3]));

end