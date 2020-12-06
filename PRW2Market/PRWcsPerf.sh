#! /bin/bash

echo "First, you need to set CS Ratios in ISTA_Net_Plus_demo.py"
cd /home/chengzi/Desktop/workspace20170624/ISTA-CS
python3 /home/chengzi/Desktop/workspace20170624/ISTA-CS/ISTA_Net_Plus_demo.py


cd /home/chengzi/Desktop/workspace20170624/ISTA-CS/voc_utils
python3 /home/chengzi/Desktop/workspace20170624/ISTA-CS/voc_utils/cocolist.py


cd /media/chengzi/FT-dataset/PRW-MGN-ReID/PRW-CS-Darknet
./darknet detector valid cfg/prw.data cfg/prw-yolov3.cfg yolov3prw.weights


cd /home/chengzi/Desktop/workspace20170624/ISTA-CS/voc_utils
python3 /home/chengzi/Desktop/workspace20170624/ISTA-CS/voc_utils/compute_VOC_mAP.py
