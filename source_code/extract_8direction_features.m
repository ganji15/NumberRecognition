function [features, fd] = extract_8direction_features(traj)
    m = length(traj(:, 1));
    fd = zeros([64, 64, 8]);
    
    for i = 1 : m
        if i > 1 && i < m
            v = traj(i - 1, :) - traj(i + 1, :);
        elseif i == m
            v = traj(i - 1, :) - traj(i, :);
        elseif i == 1
            v = traj(i, :) - traj(i + 1, :);
        end
        
        if v(1) > 0 && v(2) > 0
            fd(traj(i, 2), traj(i, 1), 4) = 1;
        elseif v(1) > 0 && v(2) <= 0
            fd(traj(i, 2), traj(i, 1), 2) = 1;
        elseif v(1) <= 0 && v(2) <= 0
            fd(traj(i, 2), traj(i, 1), 8) = 1;
        elseif v(1) <= 0 && v(2) > 0
            fd(traj(i, 2), traj(i, 1), 6) = 1;
        end
        
        if v(1) <= 0 && abs(v(2)) <= abs(v(1))
            fd(traj(i, 2), traj(i, 1), 7) = 1;
        elseif v(1) > 0 && abs(v(2)) <= abs(v(1))
            fd(traj(i, 2), traj(i, 1), 3) = 1;
        elseif v(2) <= 0 && abs(v(2)) > abs(v(1))
            fd(traj(i, 2), traj(i, 1), 1) = 1;
        elseif v(2) > 0 && abs(v(2)) > abs(v(1))
            fd(traj(i, 2), traj(i, 1), 5) = 1;
        end
    end
    
    fd = flipud(fd);
 
    for k = 1 : 8
        cp_fd = zeros(66, 66);
        cp_fd(2 : end -1, 2 : end -1) = fd(:, :, k);
        
        for i = 1 : 64
            for j = 1 : 64
                if (cp_fd(i + 1, j + 1) == 0)
                    neigbor = cp_fd(i : i + 2, j : j + 2);
                    fd(i, j, k) = max(neigbor(:));
                end
            end
        end
    end
    
    [x, y] = meshgrid(-16 : 1 : 16, -16 : 1 : 16);
    filters = 1. / 16 * exp( - (x.^2 + y.^2 ) / 32.);
    features = zeros(8, 8, 8);
    
    for k = 1 : 8
        filled_fd = zeros(64 + 25, 64 + 25);
        filled_fd(14 : end - 12, 14 : end - 12) = fd(:, :, k);
        
        for i = 4 : 8 : 64
            for j = 4 : 8 : 64
                dot = filled_fd(i + 13 - 16 : i + 13 + 16, j + 13 - 16 : j + 13 + 16) .* filters;
                features(round((i - 4) / 8 + 1), round((j - 4) / 8 + 1), k) = sum(dot(:));
            end
        end
    end
    
    features = features(:);
    norm = 0.;
    for i = 1 : 512
        if features(i) ~= 0
            features(i) = sqrt(features(i));
            %norm = norm + features(i)^2;
        end
    end
    
    %features = features / sqrt(norm);
end