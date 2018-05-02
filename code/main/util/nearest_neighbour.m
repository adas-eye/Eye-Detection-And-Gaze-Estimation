function nn = nearest_neighbour(pts, pt)
    min_dist = inf;
    for t = 1:size(pts,2)
        if norm(pts(:,t)-pt) < min_dist
            min_dist = norm(pts(:,t)-pt);
            nn = pts(:,t);
        end
    end
end