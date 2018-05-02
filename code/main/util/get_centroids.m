function centroids = get_centroids(img)
    lbl = bwlabel(img, 8);
    centroids = zeros(2,max(lbl(:)));
    for j = 1:max(lbl(:))
       [xc, yc] = centroid(lbl == j);
       centroids(:,j) = [xc; yc];
    end
end