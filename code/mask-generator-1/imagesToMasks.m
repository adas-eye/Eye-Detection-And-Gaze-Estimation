originalFolder = 'C:\Users\max\Dropbox\ee368\pkp\';

files = dir(originalFolder);

for i = 3:length(files)
    fname = files(i).name;
    img = imread(strcat(originalFolder, fname));
    mask = rgb2gray(img) >= 254;
    mask = imopen(mask, ones(5));
    mask = imclose(mask, ones(3));
    imwrite(mask, strcat(fname(1:end-4), '-mask.jpg'));
    
    imshow(mask);
end