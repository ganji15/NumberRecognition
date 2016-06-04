function [SwInv, Trs, mi] = QDFfit(data, num_per_class, qdf_h)
    if nargin < 3
       qdf_h = 0.0
    end
    
    [m, n] = size(data);
    class_num = length(num_per_class);
    indexs = ones(1, class_num + 1);
    for i = 2 : class_num + 1
        indexs(i) = indexs(i - 1) + num_per_class(i - 1);
    end
    
    mi = zeros(class_num, n);
    SwInv = zeros(n, n, class_num);
    Trs = zeros(class_num, 1);
    
    for i = 1 : class_num
        mi(i, :) = mean(data(indexs(i) : indexs(i + 1) - 1, :));
    end

    for i = 1 : class_num
        Swi = data(indexs(i) : indexs(i + 1) - 1, :)' * data(indexs(i) : indexs(i + 1) - 1, :)...
                - mi(i, :)' * mi(i, :);
        

        if qdf_h >= 0.0001
            Swi = Swi + qdf_h * eye(n);
            Trs(i) = trace(Swi);
        else
            Trs(i) = trace(Swi);
            Swi = Swi + Trs(i) * 0.5 / n * eye(n);            
        end
        
        SwInv(:, :, i) = inv(Swi);
    end
    
end

