function new_traj = fit_traj(traj)
    m = length(traj(:, 1));
    
    new_traj = traj(1, :);
    for i = 2 : m
        begin_traj = new_traj(end, :);
        end_traj = traj(i, :);
        
        v = end_traj - begin_traj;
        add_num = max(abs(v(1)), abs(v(2)));
        dx = v(1) / add_num;
        dy = v(2) / add_num;
        
        pre_traj = begin_traj;
        for p = 1 : add_num
            pre_traj = pre_traj + [dx, dy];
            new_traj = [new_traj; round(pre_traj)];
        end
        
        new_traj = [new_traj; end_traj];
    end

end