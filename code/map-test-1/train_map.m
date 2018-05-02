q4load;

thresh = 0.2;

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

save('is_eye.mat', 'is_cone', 'bin_size');