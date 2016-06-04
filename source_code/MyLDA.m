function V = MyLDA(data, num_per_class, shrinkage)
    if nargin < 3
       shrinkage = 0.0
    end
    
    [m, n] = size(data);
    class_num = length(num_per_class);
    indexs = ones(1, class_num + 1);
    for i = 2 : class_num + 1
        indexs(i) = indexs(i - 1) + num_per_class(i - 1);
    end
    
    Sw = zeros(n, n);
    Sb = zeros(n, n);
    mi = zeros(class_num, n);
    
    for i = 1 : class_num
        mi(i, :) = mean(data(indexs(i) : indexs(i + 1) - 1, :));
    end

    m = sum(mi .* repmat(num_per_class, [1 n])) / sum(num_per_class);
    
    for i = 1 : class_num
        Sb = Sb + num_per_class(i) * 1. / sum(num_per_class) * (mi(i, :) - m)' * (mi(i, :) - m);
        Swi = data(indexs(i) : indexs(i + 1) - 1, :)' * data(indexs(i) : indexs(i + 1) - 1, :)...
                - mi(i, :)' * mi(i, :);
        Swi = (1 - shrinkage) * Swi + shrinkage * eye(n);
        Sw = Sw +  num_per_class(i) * 1. / sum(num_per_class) * Swi;
    end
    
    [V, D] = eig(Sw^(-1) * Sb);
    [dummy,order] = sort(diag(-real(D)));
    V = real(V(:,order));%将特征向量按照特征值大小进行降序排列，每一列是一个特征向量
end