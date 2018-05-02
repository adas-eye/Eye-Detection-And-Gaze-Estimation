%% reset everything, import libs

clear; close all; clear; restoredefaultpath;

addpath('util');
run('../vlfeat/toolbox/vl_setup');

%% load files

load('map_detector.mat');

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

'front img'
start_time = clock();

front_img = im2double(imresize(imread(strcat('../eyes/', files(3).name)), 0.5));
front_face = front_img .* repmat(find_face(front_img), [1 1 3]);

'find face'
etime(clock(), start_time)

front_eyes = find_eyes(0, is_pos, bin_size, front_img);
front_centroids = get_centroids(front_eyes);

'find eyes'
etime(clock(), start_time)

front_idxs = find(front_eyes);
[front_is, front_js] = ind2sub(size(front_eyes), front_idxs);

'done'
etime(clock(), start_time)

%% testing

for im_idx = 4%:5%1:30
    
    'test img'
    start_time = clock();
    
    test = imresize(im2double(imgs{im_idx}), 0.5);
    test = imrotate(test, 25, 'crop');
    test_face = test .* repmat(find_face(test), [1 1 3]);
    
    'find face'
    etime(clock(), start_time)
    
    figure;
    subplot(2,1,2);
    eyes = find_eyes(1, is_pos, bin_size, test);
    
    'find eyes'
    etime(clock(), start_time)
    
    subplot(2,1,1); imshow(0.5*test + repmat(double(eyes), [1 1 3]));
    
    model = sift_match(0, single(test_face), single(front_face));

    % compute better homography using regression
    
    predictors = [model.f1(1,:)' model.f1(2,:)', ones(size(model.f1,2),1)];
    ys = model.f2(1,:)';
    xs = model.f2(2,:)';
    by = regress(ys, predictors);
    bx = regress(xs, predictors);
    mat = [by'; bx'; 0 0 1];

    'compute homography'
    etime(clock(), start_time)
    
    pts = get_centroids(eyes);
    
    newpts = pts;
    for t = 1:size(pts,2)
        pos = [pts(:,t)' 1]';
        posp = mat * pos;
        newpts(:,t) = posp(1:2);
    end
    
    'apply homography'
    etime(clock(), start_time)
    
    vectors = zeros(2,1);
    for t = 1:size(front_centroids,2)
        nn = nearest_neighbour(newpts, front_centroids(:,t));
        if norm(nn - front_centroids(:,t)) < 100
            vectors = [vectors nn-front_centroids(:,t)];
        end
    end
    meanvect = mean(vectors, 2)
    
    figure;
    subplot(1,2,1); imshow(front_img); hold on;
    plot(newpts(1,:), newpts(2,:), 'g+');
    plot(front_centroids(1,:), front_centroids(2,:), 'r+');
    subplot(1,2,2); imshow(test); hold on;
    plot(pts(1,:), pts(2,:), 'g+');
    
    'plots; done'
    etime(clock(), start_time)
    
end
