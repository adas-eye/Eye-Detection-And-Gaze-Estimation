%TODO: make this find the actual centroid

function pos = q4centroid(img)
    x = centroid1d(sum(img));
    y = centroid1d(sum(img'));
    pos = [x y]';
end

function pos = centroid1d(arr)
    arrint = cumsum(arr);
    pos = max(find(arrint <= sum(arr)/2));
end