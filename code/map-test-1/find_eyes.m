% expects a double (0 to 1) color img
function eyes = find_eyes(is_eye, bin_size, img)
    
    img_norm = abs(img+1e-3) ./ repmat(sqrt(sum(img.^2, 3)), [1 1 3]);
    img_norm(isnan(img_norm)) = 0;
    test_binned = round(floor(img_norm*255 / bin_size)+1);
    eyes = zeros(length(img_norm(:,1,1)), length(img_norm(1,:,1)));
    for i = 1:length(img_norm(:,1,1))
        for j = 1:length(img_norm(1,:,1))
            eyes(i,j) = is_eye(test_binned(i,j,1), ...
                test_binned(i,j,2), test_binned(i,j,3));
        end
    end
    eyes = bwareaopen(eyes, 10, 4);
    eyes = 1-bwareaopen(1-eyes, 1000, 4);
    eyes = eyes .* find_face(img);

end