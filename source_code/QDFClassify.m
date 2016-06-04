function [ pred_label ] = QDFClassify(feature, SwInv, Trs, mi, labels)
    label_num = length(labels);
    min_score = (feature - mi(1, :)) * SwInv(:, :, 1) * (feature - mi(1, :))' + log(Trs(1));
    min_idx = 1;
    for i = 2 : label_num
        score = (feature - mi(i, :)) * SwInv(:, :, i) * (feature - mi(i, :))' + log(Trs(i));
        if score < min_score
            min_idx = i;
            min_score = score;
        end
    end

    pred_label = labels(min_idx);
end

