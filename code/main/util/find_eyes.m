function eyes = find_eyes(disp_plot, is_pos, bin_size, img)
    
    eyes = map_classify(is_pos, bin_size, img);

    eyes = eyes .* find_face(img);
    eyes = imopen(imdilate(eyes, ones(3)), ones(5));
    
    dthresh = 10;
    threshes = [0:dthresh:500];
    nregions = zeros(1,size(threshes));
    best_thresh = 1;
    best_nregions = 0;
    for i = 1:length(threshes)
        filtered_eyes = bwareaopen(eyes, threshes(i), 8);
        connected_comps =  bwconncomp(filtered_eyes, 8);
        nregions(i) = connected_comps.NumObjects;
        if nregions(i) >= 2
            best_thresh = threshes(i);
            best_nregions = nregions(i);
        end
    end
    if disp_plot > 0
        plot(threshes, nregions);
        hold on; plot(best_thresh, best_nregions, 'o');
    end
    
    eyes = bwareaopen(eyes, best_thresh, 8);
    
end