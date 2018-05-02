%% reset everything, import libs

close all;

clear; restoredefaultpath;

addpath('util');
run('../vlfeat/toolbox/vl_setup');

%% load files

files = dir('../pkp-orig/');
img_train = {};
for i = 1:length(files)
    if strcmp(files(i).name, '.') || strcmp(files(i).name, '..')
        continue
    end
    fname = files(i).name
    img_train = [img_train, ...
        imread(strcat('../pkp-orig/', fname))];
end

files = dir('../pkp-mask/');
img_mask = {};
for i = 1:length(files)
    if strcmp(files(i).name, '.') || strcmp(files(i).name, '..')
        continue
    end
    fname = files(i).name
    img_mask = [img_mask, ...
        imread(strcat('../pkp-mask/', fname))];
end

%% train MAP detector

% count bins

'start counting bins'
start_time = clock();

bin_size = 16;
num_bins = 256/bin_size;
pos_counts = zeros(num_bins,num_bins,num_bins);
neg_counts = pos_counts;
for i = 1:30%1:length(img_train)
    train_idx = i
    img = im2double(img_train{i});
    [pos, neg] = count_pn_bins(bin_size, img, (img_mask{i} > 0) .* (sum(img,3) > 0), find_face(img));
    pos_counts = pos_counts + pos; neg_counts = neg_counts + neg;
end

'done'
etime(clock(), start_time)

actual_thresh = 0.19;

% threshold evaluation on training set

'threshold evaluation'
start_time = clock();

threshes = [0:0.01:1];
roc_curve = zeros(2,length(threshes));
specificity = zeros(1,length(threshes));
precision = zeros(1,length(threshes));
for i = 1:length(threshes)
    thresh = threshes(i);
    is_pos = double(pos_counts) > double(neg_counts) * thresh;
    tp = sum(pos_counts(is_pos)); fp = sum(pos_counts(~is_pos));
    tn = sum(neg_counts(~is_pos)); fn = sum(neg_counts(is_pos));
    tpr = tp / (tp + fn); fpr = fp / (tn + fp);
    roc_curve(:,i) = [fpr; tpr];
    specificity(i) = tn / (fp + tn); precision(i) = tp / (tp + fp);
end
plot(roc_curve(1,:), roc_curve(2,:));
hold on; plot(roc_curve(1,:), roc_curve(1,:), ':');
plot(roc_curve(1,find(threshes==actual_thresh)), roc_curve(2,find(threshes==actual_thresh)), 'o');
xlabel('fpr'); ylabel('tpr'); title('ROC curve');
figure;
plot(threshes, precision);
hold on; plot(actual_thresh, precision(find(threshes==actual_thresh)), 'o');
title('precision');

'done'
etime(clock(), start_time)

'thresholding'
start_time = clock();

is_pos = double(pos_counts) > double(neg_counts) * actual_thresh;

'done'
etime(clock(), start_time)

sum(sum(sum(is_pos==1)))
numel(is_pos)
sum(sum(sum(is_pos==1)))/numel(is_pos)

save('map_detector.mat', 'is_pos', 'bin_size');