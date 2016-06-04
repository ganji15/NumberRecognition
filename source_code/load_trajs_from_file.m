function traj = load_trajs_from_file(filename)
    file_t = fopen(filename,'r');
    %以十进制读取,且读取的数据自动排成一列，排的顺序为：先从第一行左边到第一行右边，然后排第二行
    numbers = fscanf(file_t,'%f');
    %traj = zeros(numbers(1), 2);
    traj(:, 1) = numbers(2 : 2 : end);
    traj(:, 2) = numbers(3 : 2 : end);
    
    im_nlsize=[64,64];
    x_min=min(traj(:,1));
	x_max=max(traj(:,1));
	y_min=min(traj(:,2));
	y_max=max(traj(:,2));
    fscale = 1.;
    shift = [0, 0];
    if abs(x_min - x_max) > abs(y_min - y_max)
        fscale = (im_nlsize(1)-1)/(x_max-x_min);
        shift = [0, fix((64 - (y_max - y_min) * fscale) / 2)];
    else
        fscale = (im_nlsize(2)-1)/(y_max-y_min);
        shift = [fix((64 - (x_max - x_min) * fscale) / 2), 0];
    end
    
    traj(:, 1) = round((traj(:,1) - x_min) * fscale) + 1 + shift(1);
    traj(:, 2) = round((traj(:,2) - y_min) * fscale) + 1 + shift(2);
    
    m = length(traj(:, 1));
    indexs = [1];
    for i = 2 : m
        if (traj(i, 1) ~= traj( indexs(end), 1) || traj(i, 2) ~= traj( indexs(end), 2))
            indexs = [indexs; i];
        end
    end
    
    traj = traj(indexs, :);
    traj = fit_traj(traj);
    
    %关闭文件
    fclose(file_t);
end