function plot_sample(ch, row_num, col_num)
    figure();
    for i = 1 : row_num
        for j = 1 : col_num
            subplot(col_num, row_num, (i - 1) * col_num + j);
            filename = get_filename(ch, (i - 1) * col_num + j);
            if exist(filename, 'file')
                traj = load_trajs_from_file(filename);
                traj2img(traj);
            end
        end
    end
end