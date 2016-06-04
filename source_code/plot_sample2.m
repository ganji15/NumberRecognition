function plot_sample2(idx, row_num, col_num, samples)
    if nargin < 4
        samples = [char((0 : 9) + 48), char((0 : 25) + 65), char((0 : 25) + 65 + 32)];
    end
    
    figure();
    count = 0;
    for i = 1 : row_num
        for j = 1 : col_num
            subplot(col_num, row_num, (i - 1) * col_num + j);
            count = count + 1;
            if count > length(samples)
                traj2img();
                continue;
            end
            
            ch = samples(count);
            filename = get_filename(ch, idx);
            if exist(filename, 'file')
                traj = load_trajs_from_file(filename);
                traj2img(traj);
            else
                traj2img();
            end
        end
    end
end