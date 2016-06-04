function qdf_test
    clc;
    addpath('source_code');
    %
    samples = [char((0 : 9) + 48), char((0 : 25) + 65), char((0 : 25) + 65 + 32)];
    %samples = [char((0 : 9) + 48), char((0 : 25) + 65 + 32)];
    disp('true:');
    disp(samples);
    m = length(samples);
    results = zeros(1, m);
    err_count = 0;
    begin_index = 16;
    end_index = 19;
    data_rows = end_index - begin_index + 1;
    disp(' ');
    disp('predict:');
    for j = begin_index : end_index
        for i = 1 : m
            % npc分类
            % [result, ~] = npc_classifiy(get_filename(samples(i), j));
            
            % qdf分类
            [result, ~] = qdf_classifiy(get_filename(samples(i), j));
            results(i) = result;
        end
        err_count = err_count + sum(results ~= samples);

        disp(char(results))
    end
    disp(' ');
    disp(['error: ', num2str(err_count), ' total: ' ,num2str(m * data_rows)]);
    disp(['error_rate: ', num2str(err_count / m / data_rows * 100), '%']);
    %}
end