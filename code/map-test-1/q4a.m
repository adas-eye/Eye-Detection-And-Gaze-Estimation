% JR = 30
% NHS = 42

close all;
thresh = 0.25;

bin_size = 16;

pos_counts = zeros(256/bin_size,256/bin_size,256/bin_size);
neg_counts = zeros(256/bin_size,256/bin_size,256/bin_size);

for i = 1:30%1:length(img_train)
    train_idx = i
    img = im2double(img_train{i});
    [pos, neg] = q4_count_bins(img, img_mask{i} > 0, find_face(img));
    pos_counts = pos_counts + pos; neg_counts = neg_counts + neg;
end

is_cone = double(pos_counts) > double(neg_counts) * thresh;

sum(sum(sum(is_cone==1)))
numel(is_cone)
sum(sum(sum(is_cone==1)))/numel(is_cone)

% testing

for im_idx = 1:5%1:30

    figure;
    subplot(1,2,1); imshow(img_train{im_idx});
    subplot(1,2,2); 

%     test = im2double(img_train{im_idx});
%     test = double(test) ./ repmat(sqrt(sum(test.^2, 3)), [1 1 3]);
%     test(isnan(test)) = 0;
%     test_binned = floor(test*255 / bin_size)+1;
%     eyes = zeros(length(test(:,1,1)), length(test(1,:,1)));
%     for i = 1:length(test(:,1,1))
%         for j = 1:length(test(1,:,1))
%             eyes(i,j) = is_cone(test_binned(i,j,1), ...
%                 test_binned(i,j,2), test_binned(i,j,3));
%         end
%     end
%     eyes = bwareaopen(eyes, 10, 4);
%     eyes = 1-bwareaopen(1-eyes, 1000, 4);
%     eyes = eyes .* imdilate(find_face(img_train{im_idx}), ones(20));

    eyes = find_eyes(is_cone, bin_size, im2double(img_train{im_idx}));

    imshow(0.5*im2double(img_train{im_idx}) + repmat(double(eyes), [1 1 3]));
    
    drawnow;

end