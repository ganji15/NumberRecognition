function qdf_train
    clc;
    addpath('source_code');
    dbstop if error
    chars = [char((0 : 9) + 48), char((0 : 25) + 65), char((0 : 25) + 65 + 32)];
    %chars = [char((0 : 9) + 48), char((0 : 25) + 65 + 32)];
    m = length(chars);
    train_num = 15;
    n_dim = [300, 80];
    shrinkage = 0.6;
    qdf_h = 10;
    
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
    pca_coe = coeff(:, 1 : n_dim(1));
    M = M * pca_coe;
    
    num_per_class = ones(m, 1) * train_num;
    lda_coe = MyLDA(M,num_per_class, shrinkage);
    lda_coe = lda_coe(:, 1 : n_dim(2));
    M = M * lda_coe;

    [SwInv, Trs, mi] = QDFfit(M, num_per_class, qdf_h);
    
    save source_code\QDF_TRAIN labels pca_coe lda_coe SwInv Trs mi chars
    disp 'end train ....'
end