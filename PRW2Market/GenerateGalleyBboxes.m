clear;
close all;
clc;

dbstop if error

% save detected bboxes info to 'det-result/prwdet_result.txt'
fprintf('First you must delete 1-2th line in the generated file prwdet_result.txt\n');

% prwdet_result.txt is output using Darknet and PRW-YOLOV3
detection_result = ['det-result' filesep 'prwdet_result.txt'];

fid  = fopen(detection_result,'r');
for i=1:2  %delete 2 line from .txt
    fgetl(fid);
end
buf = fread(fid,Inf);
fclose(fid);
fid  = fopen(detection_result,'w');
fwrite(fid,buf);
fclose(fid);

% test frame images directory of the PRW dataset
% img_dir = 'prw/frames/';
% galley_dir = 'gallery'
% img_dir = '/media/chengzi/FT-dataset/PRW-v16.04.20/testprw/';
fprintf('The first 2 lines in YOLOv3 detected bboxesinfo txt file will be deleted, then you must re-generate txt in each test.\n Otherwise, it gets ERROR: Index exceeds matrix dimensions. rror in calculate_ID_cam_test (line 12) \n');
detectedbboxinfo = importdata(detection_result);
frameinfo = detectedbboxinfo.textdata;
fbinfo = strsplit(frameinfo{1},',');
finfo = strsplit(fbinfo{1},filesep);
tfi = size(finfo,2);
img_dir = '';
for i=1:tfi-1
    img_dir = [img_dir finfo{i} filesep]
end
fprintf('Read reconstruced test frames from %s  \n',img_dir);

galley_dir = '/media/chengzi/FT-dataset/PRW-Market/gallery_bbox_test';

[status, message] = rmdir(galley_dir,'s');
if status==1
    fprintf('Old directory %s is removed \n',galley_dir);
else
    fprintf(message);
end

[status, message] = mkdir(galley_dir);
if status==1
    fprintf('New empty directory %s is created \n',galley_dir);
else
    fprintf(message);
end

[filename_cell, result_cell] = ImportDetectionResult(detection_result);

anno_dir = 'prw/annotations/';
img_index_test = importdata('prw/frame_test.mat');
if length(img_index_test)~=size(result_cell,1)
    fprintf('The first 2 lines in YOLOv3 detected bboxesinfo txt file will be deleted, then you must re-generate txt in each test.\n');
end

[ID_cam_gallery, miss_ID_cam, result_cell_ind] = calculate_ID_cam_test(filename_cell, result_cell, anno_dir, img_index_test);

output_dir = [galley_dir filesep];
bbox_num = calculate_gallery_feat(img_dir, output_dir, result_cell, result_cell_ind, img_index_test);
fprintf('Generated %d gallery bboxes.\n', bbox_num);

% query_dir = 'prw/query_box/';
% ID_cam_query = calculate_ID_cam_query(query_dir);
% 
% testID = ID_cam_gallery(:, 1);
% queryID = ID_cam_query(:, 1);
% testCAM = ID_cam_gallery(:, 2);
% queryCAM = ID_cam_query(:, 2);
% 
% for k = 1:length(ID_cam_query)
%     k
%     % calculate ground truth for each query (good and junk)
%     good_index = intersect(find(testID == queryID(k)), find(testCAM ~= queryCAM(k)))';% images with the same ID but different camera from the query
%     miss_index = intersect(find(miss_ID_cam(:, 1) == queryID(k)), find(miss_ID_cam(:, 2) ~= queryCAM(k))); % ground truth images missed by detection
%     miss_index = miss_index + 1000000; % A large index is assigned to ground truths that have been missed by detection
%     good_index = [good_index, miss_index'];
%     junk_index1 = find(testID == -1);% images neither good nor bad in terms of bbox quality
%     junk_index2 = intersect(find(testID == queryID(k)), find(testCAM == queryCAM(k))); % images with the same ID and the same camera as the query
%     junk_index3 = find(testID == -2); % images with ambiguous ID (-2 in the paper)
%     junk_index = [junk_index1; junk_index2; junk_index3]'; % junk images have zero impact on re-id accuracy
% end

fprintf(['Generated gallery bboxes are saved in ', output_dir, '\n']);
fprintf('Read reconstruced test frames from %s  \n',img_dir);
