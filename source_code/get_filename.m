    function filename = get_filename(char, num, dir)
        if nargin < 3
            if char >= 65 && char <= 25 + 65
                dir = '.\dataA-Z\';
            else
                dir = '.\data0-z\';
            end
        end
        
        filename = [dir, char, '_', num2str(num), '.txt'];
    end