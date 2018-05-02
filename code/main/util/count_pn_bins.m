function [pos_counts, neg_counts] = count_pn_bins(bin_size, img, map, mask)

    img = gray_normalize(img);
    pos_counts = count_bins_masked(bin_size, img, map .* mask);
    neg_counts = count_bins_masked(bin_size, img, ~map .* mask);

end