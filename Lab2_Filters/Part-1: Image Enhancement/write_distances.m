function write_distances(file_name, distances)
    fid = fopen(file_name, 'wt');
    for cell = distances
        fwrite(fid, strcat(num2str(cell{1}{2}), " ", cell{1}{1}));
        fwrite(fid, double(newline));
    end
    fclose(fid);
end

