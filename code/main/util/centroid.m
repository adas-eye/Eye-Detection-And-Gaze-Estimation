function [xc, yc] = centroid(img)
    [is, js] = ind2sub(size(img), find(img));
    xc = mean(js);
    yc = mean(is);
end