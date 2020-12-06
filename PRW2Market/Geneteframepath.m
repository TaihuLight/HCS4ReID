clear;
close all;
clc;

index = importdata('prw/frame_test.mat');
% reconstruced test frames using ISTA-Net
prwrec_testdir = '/media/chengzi/FT-dataset/PRW-v16.04.20/ISTA_HLhalfCS_rec_10_4';
prwrec_testfile = '/media/chengzi/FT-dataset/PRW-MGN-ReID/PRW-CS-Darknet/prw-test-csrec.txt';

if exist(prwrec_testfile,'file')==2
    delete(prwrec_testfile);
    fprintf('Old file %s is deleted.\n',prwrec_testfile);
end
fid = fopen(prwrec_testfile,'w');

for i = 1:size(index, 1)
    src_img_file = [prwrec_testdir filesep index{i} '.jpg\n'];
    fprintf(fid,src_img_file);
end

fclose(fid);
fprintf('Test frame is writted. \n');
