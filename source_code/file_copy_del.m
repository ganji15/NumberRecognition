samples = [char((0 : 25) + 65)];
idx = 5;

for i = 1 : length(samples)
    filename = get_filename(samples(i), idx);
    delete(filename);
end

cp_idx = 2;
for i = 1 : length(samples)
    filename = get_filename(samples(i), cp_idx);
    dst_filename = get_filename(samples(i), idx);
    copyfile(filename,dst_filename)
end