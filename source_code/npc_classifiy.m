function [res, predict_label] = npc_classifiy(filename, num_neighbors)
    load NPC_TRAIN data labels chars coe V
    if nargin < 2
        num_neighbors = 1;
    end

    traj = load_trajs_from_file(filename);
    [feature, fd] = extract_8direction_features(traj);
    feature = feature' * coe * V;
    
    predict_label = knnclassify(feature, data, labels, num_neighbors);
    res = chars(predict_label);
    
end