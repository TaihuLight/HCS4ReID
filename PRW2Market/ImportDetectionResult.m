function [filename_cell, result_cell] = ImportDetectionResult( filename )

fid = fopen( filename );
file_cell = textscan(fid, '%s');
file_cell = file_cell{1};
fclose( fid );

filename_cell = cell(size(file_cell, 1), 1);
result_cell = cell(size(file_cell, 1), 1);

for i = 1:size(file_cell, 1)
    line_cell = textscan(file_cell{i}, '%s', 'Delimiter', ',');
    line_cell = line_cell{1};
    bbox_num = (size(line_cell, 1) - 1)/4;
    bbox_cell = line_cell(2:end);
    filename = textscan(line_cell{1}, '%s', 'Delimiter', '/');
    filename = filename{1}; filename = filename{end}; filename = filename(1:end-4);
    
    filename_cell{i} = filename;
    bbox_temp = [];
    for j = 1:bbox_num
        x = round(str2num( bbox_cell{4*(j-1)+1} ));
        y = round(str2num( bbox_cell{4*(j-1)+2} ));
        w = round(str2num( bbox_cell{4*(j-1)+3} ));
        h = round(str2num( bbox_cell{4*(j-1)+4} ));
        bbox_temp = [ bbox_temp; [x y w h] ];
    end
    result_cell{i} = bbox_temp;
end
