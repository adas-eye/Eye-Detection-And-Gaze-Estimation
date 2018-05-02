% normalizes image s.t. each pixel has the same RGB vector norm
function out = gray_normalize(in)
    out = double(in) ./ repmat(sqrt(sum(in.^2, 3)), [1 1 3]);
    out(isnan(out)) = 1/sqrt(3);
end