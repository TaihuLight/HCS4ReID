#! /bin/bash

matlab -nodisplay -nojvm -nosplash -nodesktop -r "try, run('/media/chengzi/FT-dataset/PRW-MGN-ReID/PRW2Market/Geneteframepath.m'), catch, exit(1), end, exit(0);"
echo "matalb exit code: $?"

cd /media/chengzi/FT-dataset/PRW-MGN-ReID/PRW-CS-Darknet
./darknet detector test cfg/prw.data cfg/prw-yolov3.cfg yolov3prw.weights -dont_show -ext_output < prw-test-csrec.txt > /media/chengzi/FT-dataset/PRW-MGN-ReID/PRW2Market/det-result/prwdet_result.txt

echo "If the first 2 lines in the generated file 'prwdet_result.txt' is deleted, you must rerun the second step to generate a new txt!"
matlab -nodisplay -nojvm -nosplash -nodesktop -r \
   "try, run('/media/chengzi/FT-dataset/PRW-MGN-ReID/PRW2Market/GenerateGalleyBboxes.m'), catch, exit(1), end, exit(0);"
echo "matalb exit code: $?"

cd /home/chengzi/Desktop/workspace20170624/ReID-MGN
python3 /home/chengzi/Desktop/workspace20170624/ReID-MGN/train_eval.py
