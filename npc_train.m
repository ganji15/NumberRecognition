function npc_train
    clc;
    addpath('source_code');
        
    chars = [char((0 : 9) + 48), char((0 : 25) + 65), char((0 : 25) + 65 + 32)];
    %chars = [char((0 : 9) + 48), char((0 : 25) + 65 + 32)];
    m = length(chars);
    train_num = 15;
    n_dim = [300, 80];
    shrinkage = 0.8;
    
    disp 'start train ....'
    M = zeros(train_num * m, 512);
    
    labels = zeros(m, 1);
    for i = 1 : m
        for j = 1 : train_num
            filename = get_filename(chars(i), j);
            traj = load_trajs_from_file(filename);
            [feature, ~] = extract_8direction_features(traj);
            disp([chars(i),'_',num2str(j)]);
            M((i - 1) * train_num + j, :) = feature;
        end
        labels(i) = i;
    end
   
    [coeff, ~, ~, ~] = princomp(M);
    coe = coeff(:, 1 : n_dim(1));
    M = M * coe;
    
    num_per_class = ones(m, 1) * train_num;
    V = MyLDA(M,num_per_class,shrinkage);
    V = V(:, 1 : n_dim(2));
    M = M * V;
    data = zeros(m, n_dim(2));

    for i = 1 : m
        data(i, :) = mean( M((i - 1) * train_num + 1: i * train_num, :));
    end
     
    save source_code\NPC_TRAIN data labels coe V chars
    disp 'end train ....'
end