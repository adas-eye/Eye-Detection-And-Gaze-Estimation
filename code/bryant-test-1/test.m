clear;

% load vlfeat library

run('../vlfeat/toolbox/vl_setup');

% load imgs from folder

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

front_img = imresize(imread(strcat('../eyes/', files(3).name)), 0.5);

% SIFT each image to detect blobs = eyes
% works well for dark-colored eyes
% perhaps we can use SIFT descriptors to work out what the eyes are?

for im = imgs

    img = im2single(cell2mat(im));
    img = imresize(img, 0.5);
    gimg = rgb2gray(img);
    eimg = edge(gimg, 'canny');

    [f, d] = vl_sift(gimg, 'PeakThresh', 4/255);
%     figure; imshow(img); vl_plotframe(f);
%     drawnow;
    %vl_plotsiftdescriptor(d, f);
    
    model = q4_sift_match(0, front_img, img);
    
    break;
    
end
