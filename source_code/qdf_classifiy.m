function [res, predict_label] = qdf_classifiy(filename)
    load QDF_TRAIN labels pca_coe lda_coe SwInv Trs mi chars

    traj = load_trajs_from_file(filename);
    [feature, fd] = extract_8direction_features(traj);
    feature = feature' * pca_coe * lda_coe;
    
    predict_label = QDFClassify(feature, SwInv, Trs, mi, labels);
    res = chars(predict_label);
end