function result = calculate_gallery_feat(img_dir, output_dir, result_cell, result_cell_ind, img_index_test)
bbox_num = 0;
for n = 1:length(img_index_test)
    fprintf('Gallery frame ID is %d \n',n);
    box = result_cell{n};
    
    % added
    if isempty(box)
        continue;
    end
    box(:, 3:4) = box(:, 3:4) + box(:, 1:2);
    
    img = imread([img_dir img_index_test{n} '.jpg']);
    for m = 1:size(box, 1)
        coord = box(m, 1:4);
        
        % added
        if coord(1)<1, coord(1)=1; end
        if coord(2)<1, coord(2)=1; end
        if coord(3)>1920, coord(3)=1920; end
        if coord(4)>1080, coord(4)=1080; end
        
        box_img = imcrop(img, [coord(1), coord(2), max(1, coord(3)-coord(1)), max(1, coord(4)-coord(2))]);
        
        if result_cell_ind{n}(m)>478
            imwrite(box_img, [output_dir num2str(result_cell_ind{n}(m)) '_' img_index_test{n} '.jpg'], 'Quality', 90);
            bbox_num = bbox_num +1;
        end
    end
end

result = bbox_num;

