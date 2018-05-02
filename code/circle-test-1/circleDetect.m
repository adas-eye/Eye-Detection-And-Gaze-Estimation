img = imgs{1};

edgeImage = edge(rgb2gray(img));
edgeImage = imdilate(edgeImage, strel('square', 2));

[centers, radii, metric] = imfindcircles(edgeImage, [5 15], 'Sensitivity', 0.9);
centersStrong5 = centers;
radiiStrong5 = radii;
metricStrong5 = metric;
viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');
imshow(edgeImage)
viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');