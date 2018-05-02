clear;

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

addpath('../face-test-1');
run('../vlfeat/toolbox/vl_setup');